import 'package:clocknclock/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../pages/HomePage.dart';
import '../util/todo_tile.dart';
import '../util/dialog_box.dart';

//bọc lớp State bằng Widget để có thể gọi sang file Homepage
class TodoPage extends StatefulWidget {
  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State {
  // reference the hive box -- hoong biet, nao biet thi Tieen se sua cmt nhe
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // Nếu đây là lần đầu tiên mở ứng dụng chúng thì hãy tạo dữ liệu mặc định
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // Dữ liệu đã tồn tại
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // Khi Check box thay đổi, đổi trạng thái true & fales = cách phủ định biến
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Tạo theem mới task to do
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // xóa task to do
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

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
                        color: Colors.grey,
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
                              // minimumSize: const Size(185, 185),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // SvgPicture.asset('assets/images/icon_todo.svg'),
                                // const Text(
                                //   'To-Do',
                                //   style: TextStyle(fontSize: 30),
                                // )
                              ]),
                        ),
                      ),
                      Container(
                        height: 185,
                        width: 185,
                        child: ElevatedButton(
                          onPressed: createNewTask,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(185, 185),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 100),
                                // SvgPicture.asset('assets/images/icon_todo.svg'),
                                Text(
                                  'To-Do',
                                  style: TextStyle(fontSize: 30),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                  Container(
                      color: Colors.black,
                      height: 1080,
                      width: 544.5238,
                      //full mang hinh chuan tung pixels. w!
                      padding: EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: db.toDoList.length,
                        itemBuilder: (context, index) {
                          return TodoTile(
                            taskName: db.toDoList[index][0],
                            taskStatus: db.toDoList[index][1],
                            onChanged: (value) => checkBoxChanged(value, index),
                            deleteFunction: (context) => deleteTask(index),
                          );
                        },
                      ))
                ])));
  }
}
