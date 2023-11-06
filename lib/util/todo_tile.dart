import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  //Khai báo các biến cho task to do list
  final String taskName;
  final bool taskStatus;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  // Hình như là code truyền hoặc trả dữ liệu gì đấy :))
  TodoTile(
      {super.key,
      required this.taskName,
      required this.taskStatus,
      required this.onChanged,
      required this.deleteFunction});

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
          padding: const EdgeInsets.all(10),
          child: OutlinedButton(

              // Code Thiết kế task to do
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(500, 50),
                side: const BorderSide(width: 1, color: Colors.white),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                print('ToDo: why you click me ?');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TodoPage(),
                //   ),
                // );
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
                Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 20,
                      decoration: taskStatus
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ]))),
    );
  }
}
