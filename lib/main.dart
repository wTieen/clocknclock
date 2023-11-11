//add các thư viện của flutter
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// add các link file cùng folder
import '../pages/HomePage.dart';
import '../util/todo_tile.dart';

void main() async{
  // Khởi tạo the hive --- Liên quan đến lưu data cho task to do
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Mali'),
      routes: {
        "/": (context) => HomePage(),
      }
      // home: SafeArea(child: Scaffold(body: Center(child: HomePage()))),
      ));
}
