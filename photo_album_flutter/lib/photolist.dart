import 'dart:typed_data';

import './form.dart';
import './post.dart';
import './Models/photo.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

class Photos extends StatefulWidget {
  final int id;
  Photos(this.id);

  @override
  State<StatefulWidget> createState() {
    return PhotoState();
  }
}

class PhotoState extends State<Photos> {
  List photos = [];

  getPosts() async {
    http.Response response = await http.get(
      'http://192.168.0.19:3000/api/getposts/' + widget.id.toString(),
    );
    setState(() {
      photos = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  void addPhoto(
    File filePath,
    String title,
    String idea,
    BuildContext ctx,
  ) async {
    String fileName = basename(filePath.path);
    try {
      String base64Image = base64Encode(filePath.readAsBytesSync());
      http.Response resp = await http.post(
        'http://192.168.0.19:3000/api/createPost/',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode(
          {
            'file': base64Image,
            'title': title,
            'idea': idea,
            'user_id': widget.id,
            'type_file': lookupMimeType(fileName),
            'app': 'flutter',
          },
        ),
      );

      final jsonResp = json.decode(resp.body);
      showDialog<void>(
        context: ctx,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(jsonResp['title']),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(jsonResp['text']),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // FormData formData = new FormData.fromMap({
      //   'file': MultipartFile.fromString(
      //     base64.encode(filePath.readAsBytesSync()),
      //   ),
      //   'title': title,
      //   'idea': idea,
      //   'user_id': widget.id,
      //   'type_file': lookupMimeType(fileName),
      //   'app': 'flutter',
      // });

      // Response response = await Dio().post(
      //   'http://192.168.0.19:3000/api/createPost',
      //   data: formData,
      // );

      // print(
      //   response.data.toString(),
      // );
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            FormPhoto(addPhoto),
            Card(
              child: Column(
                children: photos.map(
                  (photo) {
                    return MyPost(
                      Photo(
                        title: photo['title'],
                        idea: photo['idea'],
                        image: photo['file'],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
