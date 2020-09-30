import './Models/photo.dart';
import './form.dart';

import 'package:flutter/material.dart';

class Photos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoState();
  }
}

class PhotoState extends State<Photos> {
  final List<Photo> photos = [
    Photo(
      title: 'Feliz',
      thoughts: 'En Guadalajara con mi familia',
      image: 'https://live.staticflickr.com/427/20499286135_a394391c84_b.jpg',
    ),
  ];

  void addPhoto(String title, String thoughts, String image) {
    setState(() {
      if (title == "" || thoughts == "" || image == "") {
        print('Enter some text into the input fields');
      } else {
        photos.add(Photo(title: title, thoughts: thoughts, image: image));
      }
    });
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
                    (Photo photo) {
                      return Column(children: [
                        ListTile(
                          leading: Image.network(photo.image),
                          title: Text(photo.title),
                          subtitle: Text(photo.thoughts),
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
