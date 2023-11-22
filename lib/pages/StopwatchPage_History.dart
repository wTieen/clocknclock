import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/database_time.dart';
import '../pages/HomePage.dart';
import '../pages/ClockPage.dart';
import '../pages/AlarmPage.dart';
import '../pages/StopwatchPage.dart';
import '../pages/TimerPage.dart';

enum ClockType { hour, digital, classic }

class StopwatchPageHistory extends StatefulWidget {
  @override
  StopwatchPageHistoryState createState() => StopwatchPageHistoryState();
}

class StopwatchPageHistoryState extends State<StopwatchPageHistory> {
  Color color = Colors.grey;
  late String text;

  List<Color> targetValueColor = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  List<String> recordsValue = [
    '00:01:34',
    '00:05:31',
    '00:07:04',
    '00:08:00',
    '00:11:11',
    '00:21:02',
    '00:32:33',
    '01:02:01',
    '01:22:45',
    '02:32:13',
    '02:56:38',
    '02:59:01',
    '03:30:01',
    '03:45:18',
  ];

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
                                builder: (context) => StopwatchPage(),
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
                            child: const Text('00:00:00', style: TextStyle(fontSize: 30),)
                        ),
                      ),
                    ],
                  )),
                  Container(
                      color: Colors.black,
                      height: 1080,
                      width: 450,
                      alignment: Alignment.bottomCenter,
                      child: Column(children: [
                        Title(),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // color: Colors.red,
                                height: 300,
                                width: 320,
                                alignment: Alignment.topLeft,
                                child: buildTargetList(),
                              ),
                              Container(
                                // color: Colors.red,
                                height: 300,
                                width: 120,
                                alignment: Alignment.topCenter,
                                child: BuildDrapList(),
                              ),
                            ]),
                        // const SizedBox(height: 25),
                        // tabButton(),
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTargetList() {
    return Expanded(
        child: Container(
      width: 320,
      // height: 50,
      child: ListView.builder(
        itemCount: recordsValue.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTarget(index),
                Text(recordsValue[index],
                    style: TextStyle(color: Colors.white)),
              Text(recordsValue[index],
                  style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
      ),
    ));
  }

  Widget buildTarget(i) {
    return DragTarget<Color>(
      onAccept: (data) => setState(() => targetValueColor[i] = data),
      builder: (context, _, __) => buildDragTarget(i),
      onWillAccept: (data) {
        // Trả về true nếu vùng chấp nhận dữ liệu
        return true;
      },
    );
  }

  Widget buildDragTarget(i) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        color: targetValueColor[i],
        borderRadius: BorderRadius.circular(10),
      ),
      child: null,
    );
  }

  Widget BuildDrapList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildDrap('Study', Colors.blue),
        BuildDrap('Deadline', Colors.red),
        BuildDrap('Amuse', Colors.amber),
        BuildDrap('Listen music', Colors.pink),
        BuildDrap('English', Colors.green),
        BuildDrap('Cry', Colors.purple),
      ],
    );
  }

  Widget BuildDrap(text, color) {
    return Draggable<Color>(
      data: color,
      feedback: Material(
        borderRadius: BorderRadius.circular(10),
        child: buildText(text, color),
      ),
      child: buildText(text, color),
    );
  }

  Widget buildText(String text, Color color) => Container(
        alignment: Alignment.center,
        width: 120,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10), // Đặt giá trị bo tròn tùy ý
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );

  Widget RecordList() {
    return ListView.builder(
        itemExtent: 40,
        itemCount: recordsValue.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recordsValue[index]),
            textColor: Colors.white,
          );
        });
  }

  Widget Title() {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Types', style: TextStyle(color: Colors.white)),
          Text('Records', style: TextStyle(color: Colors.white)),
          Text('Total', style: TextStyle(color: Colors.white)),
          Text('My Types', style: TextStyle(color: Colors.white)),
        ]);
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
    return number.toString().padLeft(2, '0');
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
          child: GestureDetector(
            onLongPress: () {
              // Thực hiện chuyển hướng tại đây
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StopwatchPageHistory(),
                ),
              );
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
                  angle: (_currentTime.hour % 12 + _currentTime.minute / 60) *
                      2 *
                      3.1416 /
                      12,
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
                    child: Image.asset(
                      'assets/images/needle.png',
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
                    child:
                        buildClockText(DateFormat('HH').format(_currentTime)),
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
                    child:
                        buildClockText(DateFormat('mm').format(_currentTime)),
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
                    child:
                        buildClockText(DateFormat('ss').format(_currentTime)),
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
