// //add các thư viện của flutter
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class TodoTile extends StatelessWidget {
//
//
//   //Khai báo các biến cho task to do list
//   final String taskName;
//   final bool taskStatus;
//   final String taskTime;
//
//   Function(bool?)? onChanged;
//   Function(BuildContext)? deleteFunction;
//
//   // Hình như là code truyền hoặc trả dữ liệu gì đấy :))
//   TodoTile(
//       {super.key,
//       required this.taskName,
//       required this.taskStatus,
//       required this.taskTime,
//       required this.onChanged,
//       required this.deleteFunction});
//
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       startActionPane: ActionPane(
//         motion: const StretchMotion(),
//         children: [
//           SlidableAction(
//             onPressed: deleteFunction,
//             icon: Icons.delete,
//             foregroundColor: Colors.redAccent,
//             backgroundColor: Colors.black,
//             // borderRadius: BorderRadius.circular(10),
//           )
//         ],
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         child: OutlinedButton(
//             // Code Thiết kế task to do
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.maxFinite, 20),
//               side: const BorderSide(width: 1, color: Colors.white),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//             ),
//             onPressed: () {
//               print('click task');
//             },
//             child: Row(children: [
//               // Icon đánh dấu trạng thái task to do
//               Theme(
//                 data: ThemeData(
//                   unselectedWidgetColor:
//                       Colors.white, // Màu sắc của checkbox khi chưa được chọn
//                 ),
//                 child: Checkbox(
//                     checkColor: Colors.black,
//                     value: taskStatus,
//                     onChanged: onChanged,
//                     activeColor: Colors.white),
//               ),
//               // Tên task to do
//               Container(
//                 padding:  const EdgeInsets.all(8),
//                   width: 240,
//                   child: Text(
//                     taskName,
//                     style: TextStyle(
//                         overflow: TextOverflow.clip,
//                         fontSize: 16,
//                         decoration: taskStatus
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none),
//                   )),
//               // const SizedBox(width: 10),
//                Align(
//                 alignment: Alignment.topRight,
//                 child: Text(
//                   '$taskTime PM',
//                   style: const TextStyle(
//                     fontSize:14,
//                   ),
//                 ),
//               )
//             ])),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  int? id; // ID của công việc
  String taskName; // Tên công việc
  String taskTime; // Thời gian hoàn thành
  bool taskStatus; // Trạng thái hoàn thành hay chưa

  Function(BuildContext)? deleteFunction;
  Function(bool?)? onChanged;
  TodoTile({
    this.id,
    required this.taskName,
    required this.taskTime,
    required this.taskStatus,

    required this.deleteFunction,
    required this.onChanged,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskTime': taskTime,
      'taskStatus': taskStatus ? 1 : 0,
    };
  }

  factory TodoTile.fromMap(Map<String, dynamic> map) {
    return TodoTile(
      id: map['id'],
      taskName: map['taskName'],
      taskTime: map['taskTime'],
      taskStatus: map['taskStatus'] == 1,

      onChanged: (BuildContext ) {  }, deleteFunction: (BuildContext ) {  },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            foregroundColor: Colors.redAccent,
            backgroundColor: Colors.black,
            // borderRadius: BorderRadius.circular(10),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: OutlinedButton(
          // Code Thiết kế task to do
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              minimumSize: const Size(double.maxFinite, 10),
              side: const BorderSide(width: 1, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              print('click task');
            },
            child: Row(children: [
              // Icon đánh dấu trạng thái task to do
              Theme(
                data: ThemeData(
                  unselectedWidgetColor:
                  Colors.white, // Màu sắc của checkbox khi chưa được chọn
                ),
                child: Checkbox(
                    checkColor: Colors.black,
                    value: taskStatus,
                    onChanged: onChanged,
                    activeColor: Colors.white),
              ),
              // Tên task to do
              Container(
                  padding:  const EdgeInsets.all(8),
                  width: 240,
                  child: Text(
                    taskName,
                    style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 16,
                        decoration: taskStatus
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )),
              const SizedBox(width: 10),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '$taskTime',
                  style: const TextStyle(
                    fontSize:14,
                  ),
                ),
              )
            ])),
      ),
    );
  }
}

