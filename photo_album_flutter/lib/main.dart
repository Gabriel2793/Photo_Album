import 'package:flutter/material.dart';
import './photolist.dart';

void main() => runApp(BarForm());

class BarForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album de fotos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Album de fotos'),
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
                        child: Image.network(
                          'https://static.wixstatic.com/media/e5be0b_fad9fe8956734e249e81ef539aa3d3ec~mv2_d_1591_2403_s_2.jpg',
                          width: 150,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                Photos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
