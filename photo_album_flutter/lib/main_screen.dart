import 'dart:io';

import 'package:flutter/material.dart';
import './signedUser_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'formsign.dart';
import './formsignup.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenApp();
  }
}

class MainScreenApp extends State<MainScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  int _screenChange = 0;

  void signIn(BuildContext ctx) async {
    http.Response resp = await http.post(
      'http://192.168.0.19:3000/api/signin/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode(
        {
          'email': email.text,
          'password': password.text,
        },
      ),
    );
    var success = json.decode(resp.body);
    if (success['state'] == 'error') {
      showDialog<void>(
        context: ctx,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(success['state']),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(success['message']),
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
    } else {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return SignedUserScreen(
              token: success['token'],
              id: success['id'],
              image: success['file'],
            );
          },
        ),
      );
    }
  }

  void signUp(
    File filePath,
    String email,
    String password,
    String username,
    BuildContext ctx,
  ) async {
    String fileName = basename(filePath.path);
    try {
      String base64Image = base64Encode(filePath.readAsBytesSync());
      http.Response resp = await http.post(
        'http://192.168.0.19:3000/api/registeruser/',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode(
          {
            'file': base64Image,
            'email': email,
            'password': password,
            'username': username,
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
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/album.jpg',
                  ),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[50],
                    Colors.blue[300],
                  ],
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _screenChange = 0;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.supervised_user_circle,
                          size: 34,
                          color: Colors.purple[300],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _screenChange = 1;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.supervised_user_circle,
                          size: 34,
                          color: Colors.purple[300],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.4),
              Colors.purple,
            ],
          ),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: _screenChange == 0
                    ? FormSign(email, password, signIn, 'Sign in')
                    : FormSignUp(signUp, 'Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
