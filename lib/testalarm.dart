import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/settings.dart';
import 'alarmspage.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class testAlarmPage extends StatefulWidget {
  testAlarmPage({Key? key, required this.title, }) : super(key: key);
  final String title;
  @override
  _testAlarmPageState createState() => _testAlarmPageState();
}


fireAlarm() {
  print('Alarm Fired at ${DateTime.now()}');
  print('Material Page Route?');
}


class _testAlarmPageState extends State<testAlarmPage> {
  bool isOn = false;
  int alarmId = 1;


  pushsettings() {
    print('Alarm Fired at ${DateTime.now()}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage(title: 'Settings')),
    );
    print('Material Page Route?');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 2,
          child: Switch(
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
              if (isOn == true) {
                AndroidAlarmManager.periodic(
                    Duration(seconds: 3), alarmId, fireAlarm);
                print('Alarm Timer Set');
                // fireAlarm();
              } else {
                AndroidAlarmManager.cancel(alarmId);
                isOn = false;
                print('Alarm Timer Canceled');
              }
            },
          ),
        ),
      ),
    );
  }
}


void fireAlarm1() {
  print('Alarm Fired at ${DateTime.now()}');
  // MaterialPageRoute(
  //     builder: (context) => SettingsPage(title: 'Settings'));

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //       builder: (context) =>
  //           SettingsPage(title: 'Settings')),
  // );


  print('Material Page Route?');
}


