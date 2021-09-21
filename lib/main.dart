import 'package:flutter/material.dart';
import 'package:flutter_app/set_alarm.dart';
import 'package:flutter_app/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Game Awake!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _hour = 0;
  int _min = 0;
  DateTime now = DateTime.now();

  void _updatecurrenttime() {
    setState(() {
      _hour = now.hour;
      if (_hour >= 12) {
        _hour = _hour - 12;
      } else if (_hour == 0) {
        _hour = 12;
      }
      _min = now.minute;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      print("The counter has been increased to " + _counter.toString());

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetAlarmPage(title: 'My page no. 2')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //can remove appBar if you need to
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Alarms',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'alarm times and toggles will display here',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _updatecurrenttime();
                        // Add your onPressed code here!
                      },
                      label: const Text(''),
                      icon: const Icon(Icons.access_alarm),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '$_hour : $_min',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _updatecurrenttime();
                        // Add your onPressed code here!
                      },
                      label: const Text(''),
                      icon: const Icon(Icons.access_alarm),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '$_hour : $_min',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _updatecurrenttime();
                        // Add your onPressed code here!
                      },
                      label: const Text(''),
                      icon: const Icon(Icons.access_alarm),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '$_hour : $_min',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _updatecurrenttime();
                        // Add your onPressed code here!
                      },
                      label: const Text(''),
                      icon: const Icon(Icons.access_alarm),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '$_hour : $_min',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _updatecurrenttime();
                        // Add your onPressed code here!
                      },
                      label: const Text(''),
                      icon: const Icon(Icons.access_alarm),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 0,
                child: Divider(
                  color: Colors.black,
                )),
            Expanded(
                flex: 5,
              child: Text(
                ' ',
              ),),
            Expanded(
              flex: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
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
                                    SettingsPage(title: 'Settings')),
                          );
                        },
                        child: const Text('Settings'),
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
                        child: const Text('Set New Alarm'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/* template

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

      print( "The counter has been increased to " + _counter.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //can remove appBar if you need to
      appBar: AppBar(
        // Here we take the value from the SetAlarmPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Some sample text - SCREEN 2',
            ),
            Text(
              'more sample text- SCREEN 2',
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            //changing the style of the counter number display
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        //turns the click button into a + symbol
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

 */
