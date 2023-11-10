//add các thư viện của flutter
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// add các link file cùng folder
import '../pages/TodoPage.dart';

import 'TodoPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.white,
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
                      // print('ToDo: why you click me ?');
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
                      print('Clock: why you click me ?');
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
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Exit: why you click me ?');
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
