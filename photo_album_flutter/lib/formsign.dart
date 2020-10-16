import 'package:flutter/material.dart';

class FormSign extends StatelessWidget {
  final email;
  final password;
  final Function signs;
  final String textButton;

  FormSign(this.email, this.password, this.signs, this.textButton);

  Widget build(BuildContext context) {
    return Column(
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
              this.textButton,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onPressed: () => signs(context),
          ),
        ),
      ],
    );
  }
}
