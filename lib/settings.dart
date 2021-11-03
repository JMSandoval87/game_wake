import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/set_alarm.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      print("The counter has been increased to " + _counter.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetAlarmPage(title: 'Set Alarm', slot: 2,)),
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
                  '\n# of Enemies Needed to stop alarm: 5',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            Expanded(
              flex: 50,
              child: Align(
                alignment: Alignment.topLeft,

                child: Text(
                  'Player Invincibility: y/n',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),


            Expanded(
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
                                    SetAlarmPage(title: 'Set Alarm', slot: 2,)),
                          );
                        },
                        child: const Text('Back'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Text(
                      ' ',
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}