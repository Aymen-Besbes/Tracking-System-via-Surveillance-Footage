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
