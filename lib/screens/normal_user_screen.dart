
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pcd_version_finale/screens/login_screen.dart';
import 'package:video_player/video_player.dart';

class NormalUser extends StatefulWidget {
  const NormalUser({Key? key}) : super(key: key);

  @override
  _NormalUserState createState() => _NormalUserState();
}

class _NormalUserState extends State<NormalUser> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  late VideoPlayerController _controller4;
  late Future<void> _initializeVideoPlayerFuture1;
  late Future<void> _initializeVideoPlayerFuture2;
  late Future<void> _initializeVideoPlayerFuture3;
  late Future<void> _initializeVideoPlayerFuture4;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller1 = VideoPlayerController.network(
      '/storage/emulated/0/Download/videos/videos/video1.mp4',
    );
    _controller2 = VideoPlayerController.network(
      '/storage/emulated/0/Download/videos/videos/video2.mp4',
    );
    _controller3 = VideoPlayerController.network(
      '/storage/emulated/0/Download/videos/videos/video3.mp4',
    );
    _controller4 = VideoPlayerController.network(
      '/storage/emulated/0/Download/videos/videos/video4.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture1 = _controller1.initialize();
    _initializeVideoPlayerFuture2 = _controller2.initialize();
    _initializeVideoPlayerFuture3 = _controller3.initialize();
    _initializeVideoPlayerFuture4 = _controller4.initialize();
    // Use the controller to loop the video.
    _controller1.setLooping(true);
    _controller2.setLooping(true);
    _controller3.setLooping(true);
    _controller4.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(

        title: const Text('Visualize videos'),backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body:

      GridView.count(
        crossAxisCount: 2,
        children: <Widget>[

          Expanded(
            child: FutureBuilder(
              
              future: _initializeVideoPlayerFuture4,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization,
                  // use the data it provides to limit the aspect ratio of the
                  // video.
                  return AspectRatio(
                    aspectRatio: _controller4.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_controller4),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture3,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization,
                  // use the data it provides to limit the aspect ratio of the
                  // video.
                  return AspectRatio(
                    aspectRatio: _controller3.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_controller3),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture2,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization,
                  // use the data it provides to limit the aspect ratio of the
                  // video.
                  return AspectRatio(
                    aspectRatio: _controller2.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_controller2),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture1,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization,
                  // use the data it provides to limit the aspect ratio of the
                  // video.
                  return AspectRatio(
                    aspectRatio: _controller1.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_controller1),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: Colors.grey,
              ),
              child: Center(
                child: Stack(
                  children: [
                    Icon(
                      Icons.video_camera_front,
                      size: 50,
                      color: Colors.white,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: Colors.grey,
              ),
              child: Center(
                child: Stack(
                  children: [
                    Icon(
                      Icons.video_camera_front,
                      size: 50,
                      color: Colors.white,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '6',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.deepPurpleAccent,

        backgroundColor: Colors.white,


        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller1.value.isPlaying) {
              _controller1.pause();
              _controller2.pause();
              _controller3.pause();
              _controller4.pause();
            } else {
              // If the video is paused, play it.
              _controller1.play();
              _controller2.play();
              _controller3.play();
              _controller4.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          ((_controller1.value.isPlaying))? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}
