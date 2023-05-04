import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

import 'dart:io';

class NormalUser extends StatefulWidget {
  @override
  _NormalUserState createState() => _NormalUserState();
}

class _NormalUserState extends State<NormalUser> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  VideoPlayerController? _videoController;

  List<Video> _videos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: Column(
        children: [
          if (_videoController != null &&
              _videoController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.collection('videos').orderBy('date', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                _videos = snapshot.data!.docs
                    .map((doc) => Video.fromDocument(doc))
                    .toList();

                return ListView.builder(
                  itemCount: _videos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_videos[index].camera),
                      subtitle: Text(_videos[index].date.toString()),
                      onTap: () {
                        _videoController?.pause();
                        _playVideo(_videos[index].url);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<File> videos = await _pickVideos();
          await uploadVideos(videos);
        },
        tooltip: 'Record Video',
        child: Icon(Icons.video_call),
      ),
    );
  }
  Future<List<File>> _pickVideos() async {
    List<File> files = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null) {
      List<PlatformFile> pickedFiles = result.files;
      for (var file in pickedFiles) {
        files.add(File(file.path!));
      }
    }

    return files;
  }

  Future<void> uploadVideos(List<File> videos) async {
    for (int i = 0; i < videos.length; i++) {
      final file = videos[i];
      final date = DateTime.now();
      final storageRef = _storage.ref().child('videos/$date.mp4');
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      await _db.collection('videos').add({
        'url': url,
        'date': date,
        'camera': 'Camera 1',
      });
    }
  }

  void _playVideo(String url) {
    _videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _videoController!.play();
        });
      });
  }
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

}

class Video {
  final String url;
  final DateTime date;
  final String camera;

  Video({required this.url, required this.date, required this.camera});

  factory Video.fromDocument(DocumentSnapshot doc) {
    return Video(
      url: doc['url'],
      date: doc['date'].toDate(),
      camera: doc['camera'],
    );
  }
}

