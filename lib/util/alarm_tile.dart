import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AlarmTile extends StatelessWidget {
  int? id; // ID của công việc
  String alarmName; // Tên công việc
  String alarmTime; // Thời gian hoàn thành
  bool alarmStatus; // Trạng thái hoàn thành hay chưa

  Function(BuildContext)? deleteFunction;
  Function(bool?)? onChanged;

  AlarmTile({
    this.id,
    required this.alarmName,
    required this.alarmTime,
    required this.alarmStatus,
    required this.deleteFunction,
    required this.onChanged,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'alarmName': alarmName,
      'alarmTime': alarmTime,
      'alarmStatus': alarmStatus ? 1 : 0,
    };
  }

  factory AlarmTile.fromMap(Map<String, dynamic> map) {
    return AlarmTile(
      id: map['id'],
      alarmName: map['alarmName'],
      alarmTime: map['alarmTime'],
      alarmStatus: map['alarmStatus'] == 1,
      onChanged: (BuildContext) {},
      deleteFunction: (BuildContext) {},
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
        width: 200,
        padding: const EdgeInsets.all(5),
        child: OutlinedButton(
          // Code Thiết kế task to do
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              // minimumSize: const Size(200, 10),
              side: const BorderSide(width: 1, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              print('click task');
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên task to do
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            '$alarmTime',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(bottom: 4),
                            width: 50,
                            child: Text(
                              alarmName,
                              style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 10,
                                  color: alarmStatus
                                      ? Colors.white60
                                      : Colors.white38),
                            )),
                      ]),
                  Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: alarmStatus ?? false,
                      onChanged: onChanged,
                      inactiveTrackColor: Colors.grey,
                      activeTrackColor: Colors.yellow,
                      activeColor: Colors.white,
                    ),
                  )
                ])),
      ),
    );
  }
}
