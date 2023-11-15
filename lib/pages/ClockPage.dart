import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  String? selectedValue;
  List<String> dropdownItems = ['Number clock', 'Analog clock', 'Old clock'];

  void itemSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
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
                    width: 440,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 1080,
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
                                      height: 1080,
                                      width: 220,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15),
                                          buildTab1SwitchesColumnRight(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //tab 2222222222222222222222222222
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 1080,
                                      width: 220,
                                      alignment: Alignment.topCenter,
                                      child: const Column(
                                        children: [
                                          Text('tab 2', style: TextStyle(color: Colors.white))
                                          // buildTab1SwitchesColumn(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1080,
                                      width: 220,
                                      child: const Column(
                                        children: [
                                          SizedBox(height: 15),
                                          Text('tab 2', style: TextStyle(color: Colors.white))
                                          // buildTab1SwitchesColumnRight(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //tab 33333333333333333333333333
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 1080,
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
                                      height: 1080,
                                      width: 220,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15),
                                          buildTab1SwitchesColumnRight(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //tab 44444444444444444
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 1080,
                                      width: 220,
                                      alignment: Alignment.topCenter,
                                      child: const Column(
                                        children: [
                                          Text('tab 4', style: TextStyle(color: Colors.white))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1080,
                                      width: 220,
                                      child: const Column(
                                        children: [
                                          SizedBox(height: 15),
                                          Text('tab 4', style: TextStyle(color: Colors.white))
                                          // buildTab1SwitchesColumnRight(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),





                            ],
                          ),
                        ),
                        buildTabBar(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
            padding: const EdgeInsets.only(top: 20, left: 15, right: 30),
            isExpanded: true,
            dropdownColor: Colors.black,
            style: const TextStyle(
              inherit: false,
              fontFamily: 'Mali',
              fontWeight: FontWeight.w500,
              fontSize: 16,
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
                selectedValue = newValue!;
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

  Widget buildTab1SwitchesColumn() {
    return Container(
      width: 220,
      child: Column(
        children: [
          buildSwitchListTile('24 hour format', 0),
          buildSwitchListTile('Seconds', 1),
          buildSwitchListTile('Music', 2),
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
          buildSwitchListTile('Auto time', 3),
          buildSwitchListTile('Auto time-zone', 4),
          buildSwitchListTile('Todo list', 5),
          buildSwitchListTile('Mascot', 6),
        ],
      ),
    );
  }

  Widget buildSwitchListTile(String title, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 15, top: 4, right: 10),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontFamily: 'Mali'),
      ),
      trailing: Switch(
        value: valueSwitch[index],
        onChanged: (value) {
          setState(() {
            valueSwitch[index] = !valueSwitch[index];
          });
        },
        inactiveTrackColor: Colors.grey,
        activeTrackColor: Colors.yellow,
        activeColor: Colors.white,
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
