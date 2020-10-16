import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import './Models/photo.dart';

class MyPost extends StatelessWidget {
  final Photo photo;

  MyPost(this.photo);

  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Container(
          width: 100,
          height: 150,
          child: FittedBox(
            child: Image.memory(
              Uint8List.fromList(
                base64.decode(photo.image),
              ),
            ),
            fit: BoxFit.fill,
          ),
        ),
        title: Text(photo.title),
        subtitle: Text(photo.idea),
      ),
      ButtonBar(
        children: [
          FlatButton(
            child: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
    ]);
  }
}
