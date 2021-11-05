import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/main.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_app/set_alarm.dart';
import 'package:flutter_app/settings.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';



class AlarmsPage extends StatefulWidget {
  AlarmsPage({Key? key, required this.title, required this.dtstr}) : super(key: key);
  final String title;
  final String dtstr;
  @override
  _AlarmsPageState createState() => _AlarmsPageState();
}



class _AlarmsPageState extends State<AlarmsPage> {
  int loadcount = 0;
  int _row = 5;
  int _col = 2;
  var dateTimeList = List.generate(5, (i) => List.filled(2, "NO_ALARM_SET", growable: false), growable: false);
  DateTime now = DateTime.now();
  String _note = "";
  String _dateString ="";
  String _timeString = "";
  String _dateTimeString = "";
  var _date;
  var _time;
  int testcase = 0;

  void setDateTimeArray() async {
    String dateTimeString = "";
    int partcount = 0;

    if (widget.dtstr == '') {
        File file = File(await getFilePath());
        String fileContent = await file.readAsString();
        var parts = fileContent.split(' ');

        for (var i = 0; i < _row; i++) {
          for (var j = 0; j < _col; j++) {
            dateTimeList[i][j] = parts[partcount];
            partcount++;
          }
        }
    }
    else{
      var parts = widget.dtstr.split(' ');
      for (var i = 0; i < _row; i++) {
        for (var j = 0; j < _col; j++) {
          dateTimeList[i][j] = parts[partcount];
          partcount++;
        }
      }
    }
  }

  String getTimeSting(int alarmNum){
    String timestr = "";
    setDateTimeArray();
    timestr = dateTimeList[alarmNum][0] + "\n"+ dateTimeList[alarmNum][1];
    if(timestr == ("NO_ALARM_SET"+ "\n"+"NO_ALARM_SET")){
      timestr = "No Alarm Set";
    }
    return timestr;
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/DateTimeFile.txt'; // 3
    return filePath;
  }

  void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0),() {
      setDateTimeArray();
      setState(() {});
    });

    //   @override
    // void initState() {
    //   super.initState();
    //   if (SchedulerBinding.instance!.schedulerPhase == SchedulerPhase.persistentCallbacks) {
    //     SchedulerBinding.instance!.addPostFrameCallback((_) => setDateTimeArray());
    //   }
    // }
    // setDateTimeArray();

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      _dateTimeString = getTimeSting(0),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetAlarmPage(title: 'Set Alarm', slot: 0,)),
                        );
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
                      _dateTimeString = getTimeSting(1),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetAlarmPage(title: 'Set Alarm', slot: 1,)),
                        );
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
                      _dateTimeString = getTimeSting(2),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetAlarmPage(title: 'Set Alarm', slot: 2,)),
                        );
                        setDateTimeArray();
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
                      _dateTimeString = getTimeSting(3),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetAlarmPage(title: 'Set Alarm', slot: 3,)),
                        );
                        setDateTimeArray();
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
                      _dateTimeString = getTimeSting(4),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetAlarmPage(title: 'Set Alarm', slot: 4,)),
                        );
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