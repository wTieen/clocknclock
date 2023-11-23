import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/HomePage.dart';
import '../pages/ClockPage.dart';
import '../pages/StopwatchPage.dart';
import '../pages/AlarmPage.dart';

enum ClockType { hour, timer,counting_time }
class TimerPage extends StatefulWidget {
  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final GlobalKey<_ClockExpansionTileState> _expansionTileKey =
  GlobalKey<_ClockExpansionTileState>();
  ClockType _selectedClockType = ClockType.timer;
  List<String> dropdownItems = ['Number clock', 'Timer', 'Counting time'];

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
                              child: _selectedClockType == ClockType.timer
                                  ? RunningDigitalClock()
                                  : (_selectedClockType == ClockType.hour
                                  ? Timer_Widget()
                                  : Counting_time_Widget()),
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
                                buildTab4SwitchesColumn(),
                              ],
                            ),
                          ),
                          Container(
                            // height: ,
                            width: 220,
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                buildTab4SwitchesColumnRight(),
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
            minimumSize: const Size(100, 45),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
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
            minimumSize: const Size(140, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
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
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                // Thực hiện xử lý khi giá trị thay đổi
                if (newValue == 'Number clock') {
                  _selectedClockType = ClockType.timer;
                } else if (newValue == 'Timer') {
                  _selectedClockType = ClockType.hour;
                } else if (newValue == 'Counting time') {
                  _selectedClockType = ClockType.counting_time;
                }});
              },
          ),
        ],
      ),
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
            onChanged: (value) => (title, value),
            inactiveTrackColor: Colors.grey,
            activeTrackColor: Colors.yellow,
            activeColor: Colors.white,
          ),
        ));
  }

  Widget buildTab4SwitchesColumn() {
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

  Widget buildTab4SwitchesColumnRight() {
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
  }}

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
  }}
class NewScreen extends StatelessWidget {
  final ClockType selectedClockType;

  const NewScreen({Key? key, required this.selectedClockType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget clockWidget;
    switch (selectedClockType) {
      case ClockType.hour: clockWidget = Timer_Widget();
        break;
      case ClockType.timer: clockWidget = DigitalClockWidget();
        break;
      case ClockType.counting_time: clockWidget = Counting_time_Widget();
        break;
    }

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);},
            child: clockWidget,
          ),
        ),
      ),
    );
  }}

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
  }}

class Timer_Widget extends StatefulWidget {
  @override
  Timer_WidgetState createState() => Timer_WidgetState();
}

class Timer_WidgetState extends State<Timer_Widget> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  late Timer _timer;
  bool isRunning = false;

  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildClockHand('assets/images/classic_clock_hour.png', hours),
              _buildText(':'),
              _buildClockHand('assets/images/classic_clock_minute.png', minutes),
              _buildText(':'),
              _buildClockHand('assets/images/classic_clock_second.png', seconds),
            ],
          ),
          SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isRunning) {
                    stopTimer();
                  } else {
                    startTimer();
                  }
                },
                child: Text(isRunning ? 'Tạm dừng' : 'Bắt đầu'),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: resetTimer,
                child: Text('Đặt lại'),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          _buildTimeInputFields(),
        ],
      ),
    );
  }

  Widget _buildClockHand(String imagePath, int value) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: 40.0,
              left: 40.0,
              child: Text(
                value.toString().padLeft(2, '0'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 100,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTimeInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInputField('Hours', hoursController),
        _buildInputField('Minutes', minutesController),
        _buildInputField('Seconds', secondsController),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white)),
        SizedBox(height: 5.0),
        SizedBox(
          width: 80.0,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(color: Colors.greenAccent),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void startTimer() {
    int countdownHours = int.tryParse(hoursController.text) ?? 0;
    int countdownMinutes = int.tryParse(minutesController.text) ?? 0;
    int countdownSeconds = int.tryParse(secondsController.text) ?? 0;

    int totalSeconds = (countdownHours * 3600) + (countdownMinutes * 60) + countdownSeconds;

    if (totalSeconds > 0) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (totalSeconds > 0) {
            totalSeconds--;
            hours = totalSeconds ~/ 3600;
            minutes = (totalSeconds ~/ 60) % 60;
            seconds = totalSeconds % 60;
          } else {
            stopTimer();
          }
        });
      });

      setState(() {
        isRunning = true;
      });
    }
  }

  void stopTimer() {
    _timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    setState(() {
      hours = 0;
      minutes = 0;
      seconds = 0;
      isRunning = false;
    });

    hoursController.clear();
    minutesController.clear();
    secondsController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}




class Counting_time_Widget extends StatefulWidget {
  @override
  _CountingTimeWidgetState createState() => _CountingTimeWidgetState();
}

class _CountingTimeWidgetState extends State<Counting_time_Widget> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatTime(_seconds),
            style: TextStyle(fontSize: 55, color: Colors.blue),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!_isRunning) {
                    startTimer();
                  } else {
                    pauseTimer();
                  }
                },
                child: Text(_isRunning ? 'Tạm dừng' : 'Bắt đầu'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: resetTimer,
                child: Text('Đặt lại'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}



