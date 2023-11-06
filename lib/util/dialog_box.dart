import 'package:clocknclock/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.lightBlue,
        content: Container(
            height: 120,
            child: Column(children: [
              // lấy input của user
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "task name",
                ),
              ),

              // button save và cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // button save
                  MyButton(text: "Save", onPressed: onSave),
                  const SizedBox(width: 10),
                  // button cancel
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              )
            ])));
  }
}
