import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormSignUp extends StatefulWidget {
  final Function signs;
  final String textButton;

  final picker = ImagePicker();

  FormSignUp(this.signs, this.textButton);

  @override
  State<StatefulWidget> createState() {
    return FormSignUpApp();
  }
}

class FormSignUpApp extends State<FormSignUp> {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  File _image;

  Future getImage() async {
    final pickedFile = await widget.picker.getImage(
      source: ImageSource.camera,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Username: ',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller: username,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email: ',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller: email,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password: ',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller: password,
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
        Container(
          margin: EdgeInsets.only(
            top: 12,
          ),
          child: RaisedButton(
            color: Colors.amber,
            child: Text(
              widget.textButton,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onPressed: () => widget.signs(
              _image,
              email.text,
              password.text,
              username.text,
              context,
            ),
          ),
        ),
      ],
    );
  }
}
