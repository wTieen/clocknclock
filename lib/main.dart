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

//
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           ElevatedButton(
//             onPressed: () {
//               print('ToDo: why you click me ?');
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.black,
//                 minimumSize: const Size(185, 185),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30))),
//             child: Column(mainAxisSize: MainAxisSize.min, children: [
//               SvgPicture.asset('assets/images/icon_todo.svg'),
//               const Text(
//                 'To-Do',
//                 style: TextStyle(fontSize: 30),
//               )
//             ]),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               print('Clock: why you click me ?');
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.yellow,
//                 foregroundColor: Colors.black,
//                 minimumSize: const Size(185, 185),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30))),
//             child: Column(mainAxisSize: MainAxisSize.min, children: [
//               SvgPicture.asset('assets/images/icon_clock.svg'),
//               const Text(
//                 'Clock',
//                 style: TextStyle(fontSize: 30),
//               )
//             ]),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               print('Exit: why you click me ?');
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.black,
//                 minimumSize: const Size(185, 185),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30))),
//             child: Column(mainAxisSize: MainAxisSize.min, children: [
//               SvgPicture.asset('assets/images/icon_exit.svg'),
//               const Text(
//                 'Exit',
//                 style: TextStyle(fontSize: 30),
//               )
//             ]),
//           ),
//     ]));
//     throw UnimplementedError();
//   }
// }
