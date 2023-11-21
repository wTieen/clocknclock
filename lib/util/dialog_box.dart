//add các thư viện của flutter
import 'package:flutter/material.dart';

// add các link file cùng folder
import '../util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: AlertDialog(
            backgroundColor: Colors.lightBlue,
            content: Container(
                height: 120,
                child: Column(children: [
                  // lấy input của user
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "name",
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
                ]))));
  }
}
