import 'dart:io';
import 'affichage.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  String _image = 'images/logo.png';
  String greetings = '';
  File? _file;
  PlatformFile? _platformFile;
  bool _isImageSelected = false;
  String message= ' ' ;

/*  uploadImage()async{
    final request=http.MultipartRequest("POST",Uri.parse("http://127.0.0.1:5000/upload"));
    final headers={"Content-type":"multipart/from-data"}
    request.files.add(
      http.MultipartFile('image',_file!.readAsBytes().asStream(),_file!.lengthSync,
          filename:_file!=path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson =jsonDecode(res.body);
    message=resJson['message'];
    setState(( ) { });
    )*/
  Future<void> selectFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
        _isImageSelected = true;
      });
    }
  }



  void _confirmSelection() {
    if (_isImageSelected) {
      // Do something with the selected image
      print('Selected image: ${_file!.path}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Affichage(),
        ),
      );
    } else {
      print('No image selected.');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset('images/check.png', height: 300, width: 300),
            SizedBox(height: 10),
            Text(
              'Upload the person you look for',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.deepPurple,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final pickedFile = await ImagePicker().getImage(
                                    source: ImageSource.camera,
                                  );
                                  if (pickedFile != null) {
                                    setState(() {
                                      _file = File(pickedFile.path);
                                      _isImageSelected = true;
                                      _platformFile = PlatformFile(
                                        name: pickedFile.path.split('/').last,
                                        size: 50,
                                        path: pickedFile.path,
                                      );
                                    });
                                  }
                                },
                                child: Icon(Icons.camera, color: Colors.deepPurple, size: 40),
                              ),
                              SizedBox(width: 30),
                              Positioned(
                                left: 28,
                                child: Text('Select your camera', style: TextStyle(fontSize: 15, color: Colors.grey.shade400)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Positioned(
                                right: 30,
                                child: Text('Select your folder', style: TextStyle(fontSize: 15, color: Colors.grey.shade400)),
                              ),
                              SizedBox(width: 30),
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: Icon(Icons.folder_open, color: Colors.deepPurple, size: 40),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_platformFile != null)
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected File',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(_file!, width: 70),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _platformFile!.name,
                                  style: TextStyle(fontSize: 13, color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${(_platformFile!.size / 1024).ceil()} KB',
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 0),
            if (_isImageSelected)
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  minimumSize: MaterialStateProperty.all(Size(150, 50)),
                ),
                onPressed : _confirmSelection,

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 10),
                    Text('Confirm Selection'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );




}
}





/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';


class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;
  bool _isImageSelected = false;

  final picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _isImageSelected = true;
        GallerySaver.saveImage(_imageFile!.path); // Save the image to gallery
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _isImageSelected = false;
    });
  }

  void _confirmSelection() {
    if (_isImageSelected) {
      // Do something with the selected image
      print('Selected image: ${_imageFile!.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super User Interface'),
         backgroundColor: Colors.deepPurple
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (_isImageSelected) {
                  _removeImage();
                } else {
                  _getImage(ImageSource.camera);
                }
              },
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: _imageFile != null
                    ? Image.file(_imageFile!)
                    : Center(
                  child: Icon(Icons.camera_alt, size: 50),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.deepPurple),
                      minimumSize: MaterialStateProperty.all(Size(150,50))),
                  onPressed: () => _getImage(ImageSource.camera),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('Take Photo'),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.deepPurple),
                  minimumSize: MaterialStateProperty.all(Size(150,50)),),

                  onPressed: () => _getImage(ImageSource.gallery),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 10),
                      Text('Choose from Gallery'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_isImageSelected)
              ElevatedButton(
                onPressed: _confirmSelection,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 10),
                    Text('Confirm Selection'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
 */