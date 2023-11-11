//add các thư viện của flutter
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

// add các link file cùng folder
import '../pages/HomePage.dart';
import '../util/todo_tile.dart';
import '../util/dialog_box.dart';
import '../data/database.dart';

//bọc lớp State bằng Widget để có thể gọi sang file Homepage
class TodoPage extends StatefulWidget {
  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State {
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";
  DateTime _taskTime = DateTime.now();

  // reference the hive box
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

  // Tạo thêm mới task to do
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              ]),
                        ),
                      ),
                      Container(
                        height: 185,
                        width: 185,
                        child: ElevatedButton(
                          onPressed: () {
                            createNewTask();
                            if (timeFormat == 'PM') {
                              hour += 12;
                            }
                            _taskTime = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                hour,
                                minute);
                            if (hour <= DateTime.now().hour) {
                              _taskTime = _taskTime.add(Duration(days: 1));
                            }
                            // print(_taskTime);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(185, 185),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Column(
                              //----------------------------------------------- ------------------------------------------------------
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NumberPicker(
                                        minValue: 0,
                                        maxValue: 12,
                                        value: hour,
                                        zeroPad: true,
                                        infiniteLoop: true,
                                        itemWidth: 48,
                                        itemHeight: 50,
                                        onChanged: (value) {
                                          setState(() {
                                            hour = value;
                                          });
                                        },
                                        selectedTextStyle: const TextStyle(
                                            color: Colors.black, fontSize: 30),
                                        textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.black),
                                                bottom: BorderSide(
                                                    color: Colors.black))),
                                      ),
                                      NumberPicker(
                                        minValue: 0,
                                        maxValue: 59,
                                        value: minute,
                                        zeroPad: true,
                                        infiniteLoop: true,
                                        itemWidth: 48,
                                        itemHeight: 50,
                                        onChanged: (value) {
                                          setState(() {
                                            minute = value;
                                          });
                                        },
                                        selectedTextStyle: const TextStyle(
                                            color: Colors.black, fontSize: 30),
                                        textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.black),
                                                bottom: BorderSide(
                                                    color: Colors.black))),
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                timeFormat = "AM";
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: timeFormat == "AM"
                                                    ? Colors.blue.shade800
                                                    : Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'AM',
                                                style: TextStyle(
                                                    color: timeFormat == "AM"
                                                        ? Colors.white
                                                        : Colors.white54,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  timeFormat = "PM";
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: timeFormat == "PM"
                                                      ? Colors.blue.shade800
                                                      : Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'PM',
                                                  style: TextStyle(
                                                      color: timeFormat == "PM"
                                                          ? Colors.white
                                                          : Colors.white54,
                                                      fontSize: 20),
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
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
                      padding: EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: db.toDoList.length,
                        itemBuilder: (context, index) {
                          return TodoTile(
                            taskName: db.toDoList[index][0],
                            taskStatus: db.toDoList[index][1],
                            taskTime: "$hour:$minute",
                            onChanged: (value) => checkBoxChanged(value, index),
                            deleteFunction: (context) => deleteTask(index),
                          );
                        },
                      )
                  )
                ]
            )
        )
    );
  }
}
