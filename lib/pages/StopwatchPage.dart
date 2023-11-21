import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/database_time.dart';
import '../pages/HomePage.dart';
import '../pages/ClockPage.dart';
import '../pages/AlarmPage.dart';
import '../pages/TimerPage.dart';

enum ClockType { hour, digital, classic }

class StopwatchPage extends StatefulWidget {
  @override
  StopwatchPageState createState() => StopwatchPageState();
}

class StopwatchPageState extends State<StopwatchPage> {
  // bool isSelected = false;
  final GlobalKey<_ClockExpansionTileState> _expansionTileKey =
      GlobalKey<_ClockExpansionTileState>();
  ClockType _selectedClockType = ClockType.digital;

  // String? selectedValue;
  List<String> dropdownItems = ['Number clock', 'Analog clock', 'Old clock'];

  // void itemSwitch(bool value) {
  //   setState(() {
  //     isSelected = !isSelected;
  //   });
  // }
// thêm tập key and value
  final Map<String, bool> switches = {
    '24 hour format': false,
    'Seconds': false,
    'Music': false,
    'Auto time': false,
    'Auto time-zone': false,
    'Todo list': false,
    'Mascot': false,
  };
  String textValue = 'Number clock';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Load switch states
    for (var key in switches.keys) {
      bool value = await DatabaseHelper_time.instance.getSwitchValue(key);
      setState(() {
        switches[key] = value;
        print("$key : $value");
      });
    }

    // Load text value
    String savedText = await DatabaseHelper_time.instance.getTextValue();
    setState(() {
      textValue = savedText;
    });
  }

  void updateSwitchState(String key, bool value) {
    print('Update come in');
    setState(() {
      switches[key] = value;
      print("This is in update $key : $value");
      print('Update in setState');
    });
    DatabaseHelper_time.instance.updateSwitch(key, value);
    print('Update outside');
    loadData();
  }

  void updateTextValue(String value) {
    setState(() {
      textValue = value;
    });
    DatabaseHelper_time.instance.updateText(value);
  }

  @override
  void dispose() {
    switches.forEach((key, value) async {
      await DatabaseHelper_time.instance.updateSwitch(key, value);
    });
    DatabaseHelper_time.instance.updateText(textValue!);
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
                          child: null,
                        ),
                      ),
                      Container(
                        height: 165,
                        width: 165,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewScreen(
                                  selectedClockType: _selectedClockType,
                                  // updateTextValue(''),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(165, 165),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _selectedClockType == ClockType.digital
                              ? RunningDigitalClock()
                              : (_selectedClockType == ClockType.hour
                                  ? HourClockWidget()
                                  : const Text(
                                      'Old clock',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.black),
                                    )),
                        ),
                      ),
                    ],
                  )),
                  Container(
                      color: Colors.black,
                      height: 1080,
                      width: 440,
                      alignment: Alignment.bottomCenter,
                      child: Column(children: [
                        Row(children: [
                          Container(
                            // height: ,
                            width: 220,
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                buildDropdownButton(),
                                buildTab1SwitchesColumn(),
                              ],
                            ),
                          ),
                          Container(
                            // height: ,
                            width: 220,
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                buildTab1SwitchesColumnRight(),
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(height: 25),
                        tabButton(),
                      ])),
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
            minimumSize: const Size(100, 45),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
                    // , side: const BorderSide(color: Colors.white, width: 2)
                    ),
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
            minimumSize: const Size(140, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
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

  Widget buildDropdownButton() {
    return Container(
      // height: 1080,
      width: 230,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          DropdownButton<String>(
            hint: const Text('Number clock',
                style: TextStyle(color: Colors.grey)),
            underline: Container(),
            icon: SvgPicture.asset('assets/images/icon_arrowDown.svg'),
            padding: const EdgeInsets.only(top: 10, left: 15, right: 30),
            isExpanded: true,
            dropdownColor: Colors.black,
            style: const TextStyle(
              inherit: false,
              fontFamily: 'Mali',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            value: textValue,
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                textValue = newValue!;
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
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      tabs: [
        Tab(icon: SvgPicture.asset('assets/images/icon_time.svg')),
        Tab(icon: SvgPicture.asset('assets/images/icon_alarm.svg')),
        Tab(icon: SvgPicture.asset('assets/images/icon_stopwatch.svg')),
        Tab(icon: SvgPicture.asset('assets/images/icon_timer.svg')),
      ],
      indicatorColor: Colors.yellow,
      // ),
    );
  }

  Widget buildSwitchListTile(String title) {
    return ListTile(
        contentPadding: const EdgeInsets.only(left: 15, top: 4, right: 10),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: 'Mali'),
        ),
        trailing: Transform.scale(
          scale: 0.8,
          child: Switch(
            value: switches[title] ?? false,
            onChanged: (value) => updateSwitchState(title, value),
            inactiveTrackColor: Colors.grey,
            activeTrackColor: Colors.yellow,
            activeColor: Colors.white,
          ),
        ));
  }

  // conten tab 1 + 3

  Widget buildTab1SwitchesColumn() {
    return Container(
      width: 220,
      child: Column(
        children: [
          buildSwitchListTile('24 hour format'),
          buildSwitchListTile('Seconds'),
          buildSwitchListTile('Music'),
        ],
      ),
    );
  }

  Widget buildTab1SwitchesColumnRight() {
    return Container(
      // height: 1080,
      width: 220,
      child: Column(
        children: [
          buildSwitchListTile('Auto time'),
          buildSwitchListTile('Auto time-zone'),
          buildSwitchListTile('Todo list'),
          buildSwitchListTile('Mascot'),
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
        color: Colors.black,
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
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

  String _getCurrentTime() {
    return '${_formatTwoDigits(_currentTime.hour)}:${_formatTwoDigits(_currentTime.minute)}:${_formatTwoDigits(_currentTime.second)}';
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }

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
      decoration: const BoxDecoration(
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

class ClassicClockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
