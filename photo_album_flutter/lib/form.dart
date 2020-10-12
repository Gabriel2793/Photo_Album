import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormPhoto extends StatefulWidget {
  final Function formHandler;
  FormPhoto(this.formHandler);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormPhotoApp();
  }
}

class FormPhotoApp extends State<FormPhoto> {
  final idea = TextEditingController();
  final title = TextEditingController();
  final urlImage = TextEditingController();
  Function formHandler = null;
  File _image;
  final picker = ImagePicker();

  initState() {
    this.formHandler = widget.formHandler;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(children: [
        TextFormField(
          controller: title,
          decoration: const InputDecoration(
            hintText: 'Ingresa un título',
          ),
        ),
        TextFormField(
          controller: idea,
          decoration: const InputDecoration(
            hintText: 'Describe la foto',
          ),
        ),
        Container(
          width: double.infinity,
          child: RaisedButton(
            onPressed: getImage,
            color: Colors.purple[200],
            child: Icon(
              Icons.photo_camera,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        RaisedButton(
          child: Text('Enviar'),
          onPressed: () => formHandler(_image, title.text, idea.text, context),
        ),
      ]),
    );
  }
}
