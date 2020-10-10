import 'dart:typed_data';

import './Models/photo.dart';
import './form.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class Photos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoState();
  }
}

class PhotoState extends State<Photos> {
  List photos = [];

  getPosts() async {
    http.Response response = await http.get(
      'http://192.168.0.19:3000/api/getposts/44',
    );
    photos = json.decode(response.body);
    setState(() {
      photos = json.decode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  void addPhoto(String title, String thoughts, String image) {
    // setState(() {
    //   if (title == "" || thoughts == "" || image == "") {
    //     print('Enter some text into the input fields');
    //   } else {
    //     photos.add(
    //       Photo(
    //         title: title,
    //         thoughts: thoughts,
    //         image: image,
    //       ),
    //     );
    //   }
    // });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            FormPhoto(addPhoto),
            Card(
              child: Column(
                children: [
                  ...photos.map(
                    (photo) {
                      return Column(children: [
                        ListTile(
                          leading: Image.memory(
                            Uint8List.fromList(
                              base64.decode(photo['file']),
                            ),
                          ),
                          title: Text(photo['title']),
                          subtitle: Text(photo['idea']),
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
                    },
                  ).toList(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
