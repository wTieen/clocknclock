//add các thư viện của flutter
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

// add các link file cùng folder
import '../pages/TodoPage.dart';
import '../pages/ClockPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.white,
            width: double.maxFinite,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(185, 185),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SvgPicture.asset('assets/images/icon_todo.svg'),
                      const Text(
                        'To-Do',
                        style: TextStyle(fontSize: 30),
                      )
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClockPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(185, 185),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SvgPicture.asset('assets/images/icon_clock.svg'),
                      const Text(
                        'Clock',
                        style: TextStyle(fontSize: 30),
                      )
                    ]
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                        exit(0);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(185, 185),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SvgPicture.asset('assets/images/icon_exit.svg'),
                      const Text(
                        'Exit',
                        style: TextStyle(fontSize: 30),
                      )
                    ]),
                  ),
                ])));
  }
}
