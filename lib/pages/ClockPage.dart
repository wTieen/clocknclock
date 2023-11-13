import 'dart:async';

import 'package:flutter/material.dart';

// import các file cùng thư mục
import '../pages/HomePage.dart';

enum ClockType { hour, digital, classic }

class ClockPage extends StatefulWidget {
  @override
  ClockPageState createState() => ClockPageState();
}

class ClockPageState extends State<ClockPage> {
  List<bool> valueSwitch = [false, false, false, false, false, false, false];
  bool isSelected = false;

  final GlobalKey<_ClockExpansionTileState> _expansionTileKey =
  GlobalKey<_ClockExpansionTileState>();
  ClockType _selectedClockType = ClockType.digital;

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
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: null,
                      ),
                    ),
                    Container(
                      height: 185,
                      width: 185,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewScreen(
                                selectedClockType: _selectedClockType,
                              ),
                            ),
                          );
                        },
                        child: _selectedClockType == ClockType.digital
                            ? RunningDigitalClock()
                            : (_selectedClockType == ClockType.hour
                            ? HourClockWidget()
                            : Text(
                          'Old clock',
                          style: TextStyle(
                              fontSize: 24, color: Colors.black),
                        )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(185, 185),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
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
                                  style: TextStyle(color: Colors.grey)),
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
                                fontSize: 20,
                              ),
                              value: selectedValue,
                              items: dropdownItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                  // Thực hiện xử lý khi giá trị thay đổi
                                  if (newValue == 'Number clock') {
                                    _selectedClockType = ClockType.digital;
                                  } else if (newValue == 'Analog clock') {
                                    _selectedClockType = ClockType.hour;
                                  } else if (newValue == 'Old clock') {
                                    _selectedClockType = ClockType.classic;
                                  }
                                });
                              },
                            ),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("24 hour format",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[0],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[0] = !valueSwitch[0];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("Seconds",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[1],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[1] = !valueSwitch[1];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("Music",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[2],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[2] = !valueSwitch[2];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.green,
                        height: 1080,
                        width: 272.2619,
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("Auto time",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[3],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[3] = !valueSwitch[3];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("Auto time zone",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[4],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[4] = !valueSwitch[4];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("Todo List",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[5],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[5] = !valueSwitch[5];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                              title: const Text("Linh vật",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mali',
                                  )),
                              trailing: Switch(
                                value: valueSwitch[6],
                                onChanged: (value) {
                                  setState(() {
                                    valueSwitch[6] = !valueSwitch[6];
                                  });
                                },
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: Colors.yellow,
                                activeColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClockExpansionTile extends StatefulWidget {
  const ClockExpansionTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.children = const <Widget>[],
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final List<Widget> children;

  @override
  _ClockExpansionTileState createState() => _ClockExpansionTileState();
}

class _ClockExpansionTileState extends State<ClockExpansionTile> {
  bool _isExpanded = false;

  void expand() {
    setState(() {
      _isExpanded = true;
    });
  }

  void collapse() {
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.title,
                if (widget.subtitle != null) widget.subtitle!,
              ],
            ),
          ),
          trailing: widget.trailing,
        ),
        if (_isExpanded)
          Column(
            children: widget.children,
          ),
      ],
    );
  }
}

class RunningDigitalClock extends StatefulWidget {
  @override
  _RunningDigitalClockState createState() => _RunningDigitalClockState();
}

class _RunningDigitalClockState extends State<RunningDigitalClock> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return '${_formatTwoDigits(now.hour)}:${_formatTwoDigits(now.minute)}:${_formatTwoDigits(now.second)}';
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(1, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: TextStyle(fontSize: 35, color: Colors.black),
    );
  }
}

// hiển thị full màn hình khi nhấn vào ô màu vàng...
class NewScreen extends StatelessWidget {
  final ClockType selectedClockType;

  const NewScreen({Key? key, required this.selectedClockType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget clockWidget;
    switch (selectedClockType) {
      case ClockType.hour:
        clockWidget = HourClockWidget();
        break;
      case ClockType.digital:
        clockWidget = DigitalClockWidget();
        break;
      case ClockType.classic:
        clockWidget = ClassicClockWidget();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: clockWidget,
        ),
      ),
    );
  }
}

//...
class DigitalClockWidget extends StatefulWidget {
  @override
  _DigitalClockWidgetState createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return '${_formatTwoDigits(now.hour)}:${_formatTwoDigits(now.minute)}:${_formatTwoDigits(now.second)}';
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          _currentTime,
          style: TextStyle(fontSize: 150, color: Colors.white),
        ),
      ),
    );
  }
}

//...
class HourClockWidget extends StatefulWidget {
  @override
  _HourClockWidgetState createState() => _HourClockWidgetState();
}

class _HourClockWidgetState extends State<HourClockWidget> {
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/icon_analog_clock.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 80,
              left: 90,
              child: Transform.rotate(
                angle: _currentTime.hour * 2 * 3.1416 / 12,
                child: Image.asset(
                  'assets/images/needle.png',
                  width: 9.0,
                  height: 35.0,
                  color: Colors.yellow,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 65,
              left: 89,
              child: Transform.rotate(
                angle: _currentTime.minute * 2 * 3.1416 / 60,
                child: Image.asset(
                  'assets/images/needle.png',
                  width: 25.0,
                  height: 55.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 65,
              left: 105,
              child: Transform.rotate(
                angle: _currentTime.second * 2 * 3.1416 / 60,
                child: Container(
                  width: 2.0,
                  height: 65.0,
                  color: Colors.red,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Old clock
class ClassicClockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the classic clock widget here
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          "Old clock",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
