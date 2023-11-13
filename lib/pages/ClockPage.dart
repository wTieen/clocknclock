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
        home: SafeArea(
            child: Scaffold(
                body: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: null,
                                ),
                              ),
                              Container(
                                height: 185,
                                width: 185,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('Time');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size(185, 185),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '12:12',
                                          style: TextStyle(fontSize: 50),
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
                              child: Row(
                                children: [
                                  Container(
                                      // color: Colors.pink,
                                      height: 1080,
                                      width: 272.2619,
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          DropdownButton<String>(
                                              hint: const Text('Number clock',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              padding: const EdgeInsets.all(20),
                                              isExpanded: true,
                                              dropdownColor: Colors.black,
                                              style: const TextStyle(
                                                  inherit: false,
                                                  fontFamily: 'Mali',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                              value: selectedValue,
                                              items: dropdownItems
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value));
                                              }).toList(),
                                              onChanged: (newValue) { // cập nhật thay đổi giá trị
                                                setState(() {
                                                  selectedValue = newValue!;
                                                });
                                              }),
                                          ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                            title: const Text(
                                                "24 hour format",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Mali')),
                                            trailing: Switch(
                                              value: valueSwitch[0],
                                              onChanged: (value) {
                                                setState(() {
                                                  valueSwitch[0] =
                                                      !valueSwitch[0];
                                                });
                                              },
                                              inactiveTrackColor: Colors.grey,
                                              activeTrackColor: Colors.yellow,
                                              activeColor: Colors.white,
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                            title: const Text(
                                                "Seconds",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Mali')),
                                            trailing: Switch(
                                              value: valueSwitch[1],
                                              onChanged: (value) {
                                                setState(() {
                                                  valueSwitch[1] =
                                                  !valueSwitch[1];
                                                });
                                              },
                                              inactiveTrackColor: Colors.grey,
                                              activeTrackColor: Colors.yellow,
                                              activeColor: Colors.white,
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                            title: const Text(
                                                "Music",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Mali')),
                                            trailing: Switch(
                                              value: valueSwitch[2],
                                              onChanged: (value) {
                                                setState(() {
                                                  valueSwitch[2] =
                                                  !valueSwitch[2];
                                                });
                                              },
                                              inactiveTrackColor: Colors.grey,
                                              activeTrackColor: Colors.yellow,
                                              activeColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    // color: Colors.green,
                                    height: 1080,
                                    width: 272.2619,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                          title: const Text(
                                              "Auto time",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Mali')),
                                          trailing: Switch(
                                            value: valueSwitch[3],
                                            onChanged: (value) {
                                              setState(() {
                                                valueSwitch[3] =
                                                !valueSwitch[3];
                                              });
                                            },
                                            inactiveTrackColor: Colors.grey,
                                            activeTrackColor: Colors.yellow,
                                            activeColor: Colors.white,
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                          title: const Text(
                                              "Auto time zone",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Mali')),
                                          trailing: Switch(
                                            value: valueSwitch[4],
                                            onChanged: (value) {
                                              setState(() {
                                                valueSwitch[4] =
                                                !valueSwitch[4];
                                              });
                                            },
                                            inactiveTrackColor: Colors.grey,
                                            activeTrackColor: Colors.yellow,
                                            activeColor: Colors.white,
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                          title: const Text(
                                              "Todo List",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Mali')),
                                          trailing: Switch(
                                            value: valueSwitch[5],
                                            onChanged: (value) {
                                              setState(() {
                                                valueSwitch[5] =
                                                !valueSwitch[5];
                                              });
                                            },
                                            inactiveTrackColor: Colors.grey,
                                            activeTrackColor: Colors.yellow,
                                            activeColor: Colors.white,
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                          title: const Text(
                                              "Linh vật",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Mali')),
                                          trailing: Switch(
                                            value: valueSwitch[6],
                                            onChanged: (value) {
                                              setState(() {
                                                valueSwitch[6] =
                                                !valueSwitch[6];
                                              });
                                            },
                                            inactiveTrackColor: Colors.grey,
                                            activeTrackColor: Colors.yellow,
                                            activeColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                                ],
                              ))
                        ])))));
  }
}
