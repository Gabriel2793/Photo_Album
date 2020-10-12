import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_album/main_screen.dart';
import './photolist.dart';

class SignedUserScreen extends StatelessWidget {
  final int id;
  final String token;
  final String image;

  SignedUserScreen({
    this.id,
    this.token,
    this.image,
  });

  void signOut(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return MainScreen();
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album de fotos'),
        actions: [
          IconButton(
            icon: Icon(Icons.label_outline),
            onPressed: () => signOut(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Image.asset('assets/images/paisaje.jfif'),
                  ),
                  Container(
                    child: Center(
                      child: Image.memory(
                        Uint8List.fromList(
                          base64.decode(
                            image,
                          ),
                        ),
                        width: 150,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Photos(this.id),
            ],
          ),
        ),
      ),
    );
  }
}
