import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/databaseAlarm.dart';
import '../data/database_alarm.dart';

import '../util/alarm_tile.dart';
import '../util/dialog_box.dart';
import '../pages/HomePage.dart';
import '../pages/ClockPage.dart';
import '../pages/StopwatchPage.dart';
import '../pages/TimerPage.dart';

enum ClockType { hour, digital, classic }

class AlarmPage extends StatefulWidget {
  @override
  AlarmPageState createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  var hour = 10;
  var minute = 0;
  var timeFormat = "AM";
  DateTime _alarmTime = DateTime.now();

  DatabaseHelper_alarm_list dbHelper = DatabaseHelper_alarm_list.instance;
  List<AlarmTile> alarms = [];
  final _controller = TextEditingController();

  void saveNewAlarm() async {
    AlarmTile newAlarm = AlarmTile(
      alarmName: _controller.text,
      alarmTime: '$hour : $minute',
      alarmStatus: false,
      deleteFunction: (BuildContext) {},
      onChanged: (BuildContext) {},
    );
    _controller.clear();
    await dbHelper.insertAlarm(newAlarm);
    _getAlarms();
    Navigator.of(context).pop();
  }

  void createNewAlarm() async {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewAlarm,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  final GlobalKey<_ClockExpansionTileState> _expansionTileKey =
  GlobalKey<_ClockExpansionTileState>();

// thêm tập key and value
  final Map<String, bool> switches = {
    'Sound': true,
    'Quiver': false,
    'Snooze': false,
    'Repeat': false,
  };
  @override
  void initState() {
    super.initState();
    loadData_switch();
    _getAlarms();
  }

  void _getAlarms() async {
    alarms = await dbHelper.getAllAlarms();
    setState(() {});
  }

  Future<void> loadData_switch() async {
    print('Đây là khi vào load trong alarm');
    // Load switch states
    for (var key in switches.keys) {
      bool value = await DatabaseHelper_alarm_switch.instance.getSwitchValue(key);
      setState(() {
        switches[key] = value;
        print('This for alarm menu');
        print("$key : $value");
      });
    }
    // Load text value
  }

  void updateSwitchState(String key, bool value) {
    print('Update come in alarm');
    setState(() {
      switches[key] = value;
      print("This is in update $key : $value");
      print('Update in setState');
    });
    DatabaseHelper_alarm_switch.instance.updateSwitch(key, value);
    print('Update outside');
    loadData_switch();
  }

  @override
  void dispose() {
    switches.forEach((key, value) async {
      await DatabaseHelper_alarm_switch.instance.updateSwitch(key, value);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: Container(
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
                              createNewAlarm();
                              if (timeFormat == 'PM') {
                                hour += 12;
                              }
                              _alarmTime = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                hour,
                                minute,
                              );
                              if (hour <= DateTime.now().hour) {
                                _alarmTime = _alarmTime.add(Duration(days: 1));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NumberPicker(
                                        minValue: 0,
                                        maxValue: 23,
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
                                            top:
                                            BorderSide(color: Colors.black),
                                            bottom:
                                            BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
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
                                            top:
                                            BorderSide(color: Colors.black),
                                            bottom:
                                            BorderSide(color: Colors.black),
                                          ),
                                        ),
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
                    alignment: Alignment.bottomCenter,
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                            height:260,
                            width: 220,
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Colors.black,
                              height: 300,
                              width: 440,
                              padding: EdgeInsets.all(4),
                              child: ListView.builder(
                                itemCount: alarms.length,
                                itemBuilder: (context, index) {
                                  AlarmTile alarm = alarms[index];
                                  return AlarmTile(
                                    alarmName: alarm.alarmName,
                                    alarmStatus: alarm.alarmStatus,
                                    alarmTime: alarm.alarmTime,
                                    onChanged: (value) {
                                      setState(() {
                                        alarm.alarmStatus = !alarm.alarmStatus;
                                        dbHelper.updateAlarm(alarm);
                                        _getAlarms();
                                      });
                                    },
                                    deleteFunction: (context) {
                                      setState(() {
                                        dbHelper.deleteAlarm(alarm.id);
                                        _getAlarms();
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            // height: ,
                            width: 220,
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                buildTab2SwitchesColumnRight(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      tabButton(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tabButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClockPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(100, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // side: const BorderSide(color: Colors.white, width: 2)
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SvgPicture.asset('assets/images/icon_time.svg'),
          ]),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlarmPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(140, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SvgPicture.asset('assets/images/icon_alarm.svg'),
          ]),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StopwatchPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(100, 45),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
              // , side: const BorderSide(color: Colors.white, width: 2)
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SvgPicture.asset('assets/images/icon_stopwatch.svg'),
          ]),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimerPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(100, 45),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
              // , side: const BorderSide(color: Colors.white, width: 2)
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SvgPicture.asset('assets/images/icon_timer.svg'),
          ]),
        ),
      ],
    );
  }

  // Widget buildDropdownButton() {
  //   return Container(
  //     // height: 1080,
  //     width: 230,
  //     alignment: Alignment.topCenter,
  //     child: Column(
  //       children: [
  //         DropdownButton<String>(
  //           hint: const Text('Number clock',
  //               style: TextStyle(color: Colors.grey)),
  //           underline: Container(),
  //           icon: SvgPicture.asset('assets/images/icon_arrowDown.svg'),
  //           padding: const EdgeInsets.only(top: 10, left: 15, right: 30),
  //           isExpanded: true,
  //           dropdownColor: Colors.black,
  //           style: const TextStyle(
  //             inherit: false,
  //             fontFamily: 'Mali',
  //             fontWeight: FontWeight.w500,
  //             fontSize: 16,
  //           ),
  //           value: textValue,
  //           items: dropdownItems.map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(value),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             setState(() {
  //               textValue = newValue!;
  //               // updateTextValue(textValue);
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildSwitchListTile(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 15, top: 4, right: 10),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontFamily: 'Mali'),
      ),
      trailing: Switch(
        value: switches[title] ?? false,
        onChanged: (value) => updateSwitchState(title, value),
        inactiveTrackColor: Colors.grey,
        activeTrackColor: Colors.yellow,
        activeColor: Colors.white,
      ),
    );
  }

  // Widget buildTab2SwitchesColumn() {
  //   return Container(
  //     width: 220,
  //     child: Column(
  //       children: [
  //         buildSwitchListTile('24 hour format'),
  //         buildSwitchListTile('Seconds'),
  //         buildSwitchListTile('Music'),
  //       ],
  //     ),
  //   );
  // }

  Widget buildTab2SwitchesColumnRight() {
    return Container(
      // height: 1080,
      width: 220,
      child: Column(
        children: [
          buildSwitchListTile('Sound'),

          buildSwitchListTile('Quiver'),
          buildSwitchListTile('Snooze'),
          buildSwitchListTile('Repeat'),
        ],
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
      style: TextStyle(fontSize: 30, color: Colors.black),
    );
  }
}

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
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: Center(
            child: clockWidget,
          ),
        ),
      ),
    );
  }
}

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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        width: 280.0,
        height: 280.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/icon_analog_clock.png',
                width: 280.0,
                height: 280.0,
                fit: BoxFit.cover,
              ),
              // Kim giờ
              Positioned(
                top: 100.0,
                left: 150.0,
                child: Transform.rotate(
                  angle: (_currentTime.hour % 12 + _currentTime.minute / 60) * 2 * 3.1416 / 12,
                  child: Transform.translate(
                    offset: const Offset(10.0, 10.0),
                    child: Image.asset(
                      'assets/images/needle.png',
                      width: 10.0,
                      height: 55.0,
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Kim phút
              Positioned(
                top: 85.0,
                left: 124.0,
                child: Transform.rotate(
                  angle: _currentTime.minute * 2 * 3.1416 / 60,
                  child: Transform.translate(
                    offset: const Offset(10.0, 10.0),
                    // Điều chỉnh vị trí của kim phút
                    child: Image.asset('assets/images/needle.png',
                      width: 20.0,
                      height: 80.0,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Kim giây
              Positioned(
                top: 99.80,
                left: 145.00,
                child: Transform.rotate(
                  angle: _currentTime.second * 2 * 3.1416 / 60,
                  child: Transform.translate(
                    offset: const Offset(5.0, 5.0),
                    // Điều chỉnh vị trí của kim giây
                    child: Container(
                      width: 3.50,
                      height: 100.0,
                      color: Colors.red,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//Old clock
class ClassicClockWidget extends StatefulWidget {
  @override
  _ClassicClockWidgetState createState() => _ClassicClockWidgetState();
}

class _ClassicClockWidgetState extends State<ClassicClockWidget> {
  late DateTime _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    // Update time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/classic_clock_hour.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: buildClockText(DateFormat('HH').format(_currentTime)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/classic_clock_minute.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: buildClockText(DateFormat('mm').format(_currentTime)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/classic_clock_second.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: buildClockText(DateFormat('ss').format(_currentTime)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildClockText(String timeValue) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Text(
        timeValue,
        style: TextStyle(
          color: Colors.white, // Màu chữ của đồng hồ
          fontSize: 100,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
