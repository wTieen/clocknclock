import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

import '../pages/HomePage.dart';
import '../util/todo_tile.dart';
import '../util/dialog_box.dart';
import '../data/database.dart';

class TodoPage extends StatefulWidget {
  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";
  DateTime _taskTime = DateTime.now();

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

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
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.black,
                    height: 1080,
                    width: 300,
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ),
                    ),
                  ),
                  Container(
                    height: 165,
                    width: 165,
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
                          minute,
                        );
                        if (hour <= DateTime.now().hour) {
                          _taskTime = _taskTime.add(Duration(days: 1));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(165, 165),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                  textStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black),
                                      bottom: BorderSide(color: Colors.black),
                                    ),
                                  ),
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
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                  textStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black),
                                      bottom: BorderSide(color: Colors.black),
                                    ),
                                  ),
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: timeFormat == "AM"
                                              ? Colors.blue.shade800
                                              : Colors.blue,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'AM',
                                          style: TextStyle(
                                            color: timeFormat == "AM"
                                                ? Colors.white
                                                : Colors.white54,
                                            fontSize: 16,
                                          ),
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: timeFormat == "PM"
                                              ? Colors.blue.shade800
                                              : Colors.blue,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'PM',
                                          style: TextStyle(
                                            color: timeFormat == "PM"
                                                ? Colors.white
                                                : Colors.white54,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 1080,
              width: 440,
              padding: EdgeInsets.all(16),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
