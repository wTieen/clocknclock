//add các thư viện của flutter
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

// add các link file cùng folder
import '../pages/HomePage.dart';

class ClockPage extends StatefulWidget {
  @override
  ClockPageState createState() => ClockPageState();
}

class ClockPageState extends State {
  DateTime realTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.black,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        height: 1080,
                        width: 321,
                        child: ElevatedButton(
                          onPressed: () {
                            print('OutToDo: why you click me ?');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Column(
                              mainAxisSize: MainAxisSize.min, children: []),
                        ),
                      ),
                      Container(
                        height: 185,
                        width: 185,
                        child: ElevatedButton(
                          onPressed: () {
                            print('Time');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(185, 185),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '12:12',
                                  style: TextStyle(fontSize: 50),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      color: Colors.black,
                      height: 1080,
                      width: 544.5238,
                      //full mang hinh chuan tung pixels. w!
                      // padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.blue,
                            height: 1080,
                            width: 272.2619,
                            child: const Text('XXXX'),
                          ),
                          Container(
                            color: Colors.green,
                            height: 1080,
                            width: 272.2619,
                            child: const Text('XXXX'),
                          )
                        ],
                      )),
                ])));
  }
}
