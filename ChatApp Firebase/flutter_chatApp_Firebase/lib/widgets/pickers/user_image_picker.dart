import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFun);

  final void Function(File pickedImage) imagePickFun;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFun(File(pickedImageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        )
      ],
    );
  }
}
