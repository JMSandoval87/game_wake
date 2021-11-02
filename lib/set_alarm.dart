import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_app/set_alarm.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class SetAlarmPage extends StatefulWidget {
  final int slot;
  final String title;

  SetAlarmPage({Key? key, required this.title, required this.slot}) : super(key: key);



  @override
  _SetAlarmPageState createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  List<List<String>> dateTimeList = List.generate(5, (i) => List.filled(2, "NO_ALARM_SET", growable: false), growable: false);
  int get slot => this.slot;
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  String _note = "";
  String _dateString ="";
  String _timeString = "";
  var _date;
  var _time;
  int _row = 5;
  int _col = 2;


  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/DateTimeFile.txt'; // 3
    print(filePath);
    return filePath;
  }


  void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
    print('File Content:' + fileContent);
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
    var tList = List.generate(_row, (i) => List.filled(_col, "NO_ALARM_SET", growable: false), growable: false);
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
    file.writeAsString(""); // 2
    print(getFilePath());

    var parts = fileContent.split(' ');
    int partcount = 0;

    for (var i = 0; i < _row; i++) {
      for (var j = 0; j < _col; j++) {
        tList[i][j] = parts[partcount];
        partcount = partcount + 1;
      }
    }

    print("contents of array being saved");
    File fileSave = File(await getFilePath());
    print(tList);
    for (var i = 0; i < _row; i++) {
      for (var j = 0; j < _col-1; j++) {

        if (i == widget.slot){
          tList[i][j] = _timeString;
          tList[i][j+1] = _dateString;
          fileSave..writeAsStringSync(_timeString, mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
          fileSave..writeAsStringSync(_dateString, mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
        }
        else{
          fileSave..writeAsStringSync(tList[i][j], mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
          fileSave..writeAsStringSync(tList[i][j+1], mode: FileMode.append);
          fileSave..writeAsStringSync(" ", mode: FileMode.append);
        }

        print(tList[i][j]);
        print(tList[i][j+1]);
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
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialTime: TimeOfDay(hour: 5, minute: 00),
                      dateMask: 'hh:mm a',

                      icon: Icon(Icons.access_alarms),
                      timeLabelText: 'Time',
                      onChanged: (val) {
                        // print("time period: "+_tTime.period);
                        print("print from here:");
                        _timeString = val;
                        print(_timeString);
                        print("slot:");
                        print(widget.slot);
                      },

                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) {
                        print(val);
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
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    onChanged: (val) {
                      // print("time period: "+_tTime.period);
                      print("print from here:");
                      _dateString = val;
                      print(_dateString);
                    },

                    validator: (val) {
                      print(val);
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
                            // print("Reading File Before Save");
                            // readFile();
                            print("saving file:");
                            saveFile();
                            // print("Reading File After Save");
                            // readFile();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'GameAwake!')),
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
