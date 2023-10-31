import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Mali'),
    home: SafeArea(child: Scaffold(body: Center(child: homeButton()))),
    debugShowCheckedModeBanner: false,
  ));
}

class homeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        onPressed: () {
          print('why you click me ?');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.black,
            minimumSize: const Size(185, 185),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/icon_todo.png'),
              const Text(
                'To-Do',
                style: TextStyle(fontSize: 30),
              )
              // child: const Text: ('To-Do')
            ]),
      ),
      ElevatedButton(
        onPressed: () {
          print('why you click me ?');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            minimumSize: const Size(185, 185),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/icon_clock.png'),
              const Text(
                'Clock',
                style: TextStyle(fontSize: 30),
              )
              // child: const Text: ('To-Do')
            ]),
      ),
      ElevatedButton(
        onPressed: () {
          print('why you click me ?');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
            minimumSize: const Size(185, 185),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/icon_exit.png'),
              const Text(
                'Exit',
                style: TextStyle(fontSize: 30),
              )
              // child: const Text: ('To-Do')
            ]),
      ),
    ]

            // ElevatedButton(
            //     onPressed: () {
            //       print('you click me');
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue,
            //         foregroundColor: Colors.black,
            //         minimumSize: const Size(185, 185),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30))),
            //     child: const Text(
            //       'Clock',
            //       style: TextStyle(fontSize: 30),
            //     )),
            // ElevatedButton.icon(
            //     onPressed: () {
            //       print('you click me');
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue,
            //         foregroundColor: Colors.black,
            //         minimumSize: const Size(185, 185),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30))),
            //     icon: const Icon(
            //       Icons.edit,
            //       size: 30,
            //     ),
            //     label: const Text(
            //       'Exit',
            //       style: TextStyle(fontSize: 30),
            //     )
            // ),
            ));

    throw UnimplementedError();
  }
}
