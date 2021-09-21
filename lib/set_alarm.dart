import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/set_alarm.dart';

class SetAlarmPage extends StatefulWidget {
  SetAlarmPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SetAlarmPageState createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      print("The counter has been increased to " + _counter.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Game Awake!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //can remove appBar if you need to
      appBar: AppBar(
        // Here we take the value from the SettingsPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.topLeft,

                child: Text(
                  '\nTime:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.topLeft,

                child: Text(
                  'Date:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.topLeft,

                child: Text(
                  'Repeat?',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            Expanded(
              flex: 30,
              child: Align(
                alignment: Alignment.topLeft,

                child: Text(
                  'Alarm Sound -',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Expanded(
                flex: 10,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 25,
                      child: ButtonTheme(
                        child: ElevatedButton(
                          onPressed: () {
                            _incrementCounter();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'GameAwake!')),
                            );
                          },
                          child: const Text('cancel'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Text(
                        ' ',
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: ButtonTheme(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SetAlarmPage(title: 'Set Alarm')),
                            );
                          },
                          child: const Text('Set Alarm'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
