import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SaveImageScreen extends StatelessWidget {
  final XFile image;

  const SaveImageScreen({required this.image});

  Future<void> _saveImageToGallery(context) async {
    try {
      final bool? isSaved = await GallerySaver.saveImage(image.path);
      if (isSaved!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved to gallery.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image to gallery.')),
        );
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Image Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(image.path)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveImageToGallery(context);
              },
              child: Text('Save Image'),
            ),
          ],
        ),
      ),
    );
  }
}