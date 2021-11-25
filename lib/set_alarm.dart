import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_app/set_alarm.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'alarmspage.dart';


class SetAlarmPage extends StatefulWidget {
  final int slot;
  final String title;

  SetAlarmPage({Key? key, required this.title, required this.slot}) : super(key: key);



  @override
  _SetAlarmPageState createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  List<List<String>> dateTimeList = List.generate(5, (i) => List.filled(3, "NO_ALARM_SET", growable: false), growable: false);
  int get slot => this.slot;
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  String _note = "";
  String _dateString ="";
  String _timeString = "";
  String _alarmStatus = "";
  String _strSend = "";
  var _date;
  var _time;
  int _row = 5;
  int _col = 3;


  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/DateTimeFile.txt'; // 3
    return filePath;
  }


  void initializeFile() async {
    File file = File(await getFilePath());
    for (var i = 0; i < _row; i++) {
        file..writeAsStringSync("NO_ALARM_SET ", mode: FileMode.append);
        file..writeAsStringSync("NO_ALARM_SET ", mode: FileMode.append);
        file..writeAsStringSync("NO_ALARM_SET ", mode: FileMode.append);
    }
    readFile();
  }

  void checkInit() async {
    File file = File(await getFilePath());
    if ((await File("path/to/file").exists()) == false){
      initializeFile();
    }
  }


  void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
  }


  void getFileString() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
    _strSend = fileContent;
  }


  void setDateTimeArray() async {
    String dateTimeString = "";
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
    var parts = fileContent.split(' ');
    int partcount = 0;
    for (var i = 0; i < _row; i++) {
      for (var j = 0; j < _col; j++) {
        dateTimeList[i][j] = parts[partcount];
        partcount++;
      }
    }
  }




  void saveFile() async {
    var now = new DateTime.now();
    var tList = List.generate(_row, (i) => List.filled(_col, "NO_ALARM_SET", growable: false), growable: false);
    File file = File(await getFilePath());
    if ((await File("path/to/file").exists()) == false){
      initializeFile();
    }

    String fileContent = await file.readAsString();
    file.writeAsString(""); // 2

    var parts = fileContent.split(' ');

    int partcount = 0;
    for (var i = 0; i < _row; i++) {
      for (var j = 0; j < _col; j++) {
        tList[i][j] = parts[partcount];
        partcount = partcount + 1;
      }
    }

    File fileSave = File(await getFilePath());
    for (var i = 0; i < _row; i++) {
        if (i == widget.slot){
          if (_timeString == ""){
            var formatter = new DateFormat('HH:mm');
            String formattedDate = formatter.format(now);
            _timeString = formattedDate;
          }

          if (_dateString == ""){
            var formatter = new DateFormat('yyyy-MM-dd');
            String formattedDate = formatter.format(now);

            _dateString = formattedDate;
          }

          if (_alarmStatus == ""){
            _alarmStatus = "1";
          }

          tList[i][0] = _timeString;
          tList[i][1] = _dateString;
          tList[i][2] = _alarmStatus;
          fileSave..writeAsStringSync(_timeString, mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
          fileSave..writeAsStringSync(_dateString, mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
          fileSave..writeAsStringSync(_alarmStatus, mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
        }
        else{
          fileSave..writeAsStringSync(tList[i][0], mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
          fileSave..writeAsStringSync(tList[i][1], mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
          fileSave..writeAsStringSync(tList[i][2], mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
        }
    }
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
                  '',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            Expanded(
              flex: 10,
              child: Align(
                  alignment: Alignment.topLeft,

                  child:
                  DateTimePicker(
                    type: DateTimePickerType.time,
                    // use24HourFormat: false,
                    locale: Locale('en', 'US'),
                    initialValue: DateFormat.Hm().format(DateTime.now()).toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialTime: TimeOfDay.now(),
                    dateMask: 'hh:mm a',

                    icon: Icon(Icons.access_alarms),
                    timeLabelText: 'Time',
                    onChanged: (val) {
                      _timeString = val;
                    },

                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) {
                    },
                  )
              ),
            ),

            Expanded(
              flex: 10,
              child: Align(
                  alignment: Alignment.topLeft,
                  child:
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    initialValue: DateFormat.MMMMd()
                        .format(DateTime.now())
                        .toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    onChanged: (val) {
                      _dateString = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) => print(val),
                  )
              ),
            ),
            Expanded(
              flex: 40,
              child: Align(
                alignment: Alignment.topLeft,

                child: Text(
                  '',
                  style: TextStyle(fontSize: 1),
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
                          getFileString();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AlarmsPage(title: 'Game Awake!', dtstr: _strSend, lastalarm: "",)),
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
                        onPressed: ()  {
                          getFileString();
                          saveFile();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AlarmsPage(title: 'Game Wake!', dtstr: _strSend, lastalarm: "")),
                          );
                        },
                        child: const Text('Set Alarm'),
                      ),
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