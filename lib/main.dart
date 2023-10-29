import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Mali'),
    home: const SafeArea(
        child: Scaffold(
      body: Center (child: Text('hello clock'),)
    )),
  ));
}
