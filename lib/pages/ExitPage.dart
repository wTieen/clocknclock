//add các thư viện của flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// add các link file cùng folder
import '../pages/HomePage.dart';

class ClockPage extends StatefulWidget {
  @override
  ClockPageState createState() => ClockPageState();
}

class ClockPageState extends State {
  List<bool> valueSwitch = [false, false, false, false, false, false, false];
  bool isSelected = false;

  void itemSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  String? selectedValue;
  List<String> dropdownItems = ['Number clock', 'Analog clock', 'Old clock'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,


            child: Scaffold(
                body: Container(



                  child: Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [

                            Tab(text: 'Tab 1'),
                            Tab(text: 'Tab 2'),
                            Tab(text: 'Tab 3'),
                            Tab(text: 'Tab 4'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Nội dung của Tab 1
                              Container(
                                  alignment: Alignment.center,
                                child: const Text('Content for Tab 2', style: TextStyle(color: Colors.white)),
                              ),

                              // Nội dung của Tab 2
                              Container(
                                alignment: Alignment.center,
                                child: const Text('Content for Tab 2', style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Text('Content for Tab 3', style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Text('Content for Tab 4', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),








                )
















            ))









    );
  }
}
