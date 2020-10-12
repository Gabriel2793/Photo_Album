import 'dart:io';

import 'package:flutter/material.dart';
import './signedUser_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
                child: Column(
                  children: [
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
                      margin: EdgeInsets.only(
                        top: 12,
                      ),
                      child: RaisedButton(
                        color: Colors.amber,
                        child: Text(
                          'Send',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => signIn(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
