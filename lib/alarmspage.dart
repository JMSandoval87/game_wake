import 'package:flutter/material.dart';
import 'package:flutter_app/set_alarm.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'game.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AlarmsPage extends StatefulWidget {
  AlarmsPage({Key? key, required this.title, required this.dtstr, required this.lastalarm}) : super(key: key);
  final String title;
  final String dtstr;
  final String lastalarm;
  @override
  _AlarmsPageState createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {
  int loadcount = 0;
  int _row = 5;
  int _col = 3;
  var dateTimeList = List.generate(5, (i) => List.filled(3, "NO_ALARM_SET", growable: false), growable: false);
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
    Future.delayed(Duration(seconds: 1),() {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      setDateTimeArray();
      setState(() {});

      for (var i = 0; i < _row; i++) {
        if((dateTimeList[i][1] + " "+ dateTimeList[i][0]) == formattedDate
            && dateTimeList[i][2] == "1" && widget.lastalarm != formattedDate){
          dateTimeList[i][2] = "-1";
          print("Alarm for "+formattedDate+" was activated");
          FlutterRingtonePlayer.playAlarm();
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => runG(title: 'GAME WAKE!', lastalarm: formattedDate)),
          );
        }
      }
    });
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
                    child: Text(""),
                    // ButtonTheme(
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       FlutterRingtonePlayer.stop();
                    //     },
                    //     child: const Text('test1'),
                    //   ),
                    // ),
                  ),
                  Expanded(
                    flex: 25,
                    child: Text(""),
                    // ButtonTheme(
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //             runGame(title: 'Game', lastalarm: "fdsa",),)
                    //       );
                    //     },
                    //     child: const Text('test2'),
                    //   ),
                    // ),
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