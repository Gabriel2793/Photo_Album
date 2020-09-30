import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class Photo {
  final String title;
  final String thoughts;
  final String image;

  Photo({@required this.title, @required this.thoughts, @required this.image});
}
