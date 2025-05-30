import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File) onSaved;
  
  const ImageInput({super.key, required this.onSaved});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _image;
  void _takePicture() async {
    final imagePicker = ImagePicker();

    final img = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (img == null) return;
    final image = File(img.path);
    widget.onSaved(image);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: Icon(Icons.camera),
      label: Text('Take picture'),
    );

    if (_image != null) {
      content = GestureDetector(onTap: _takePicture, child: Image.file(_image!, fit: BoxFit.cover, width: double.infinity, height: double.infinity,));
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(50),
        ),
      ),
      child: content,
    );
  }
}
