import 'package:flutter/material.dart';
import './main_screen.dart';

void main() => runApp(BarForm());

class BarForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album de fotos',
      home: MainScreen(),
    );
  }
}
