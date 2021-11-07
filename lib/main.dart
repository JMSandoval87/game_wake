import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_app/alarmspage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}


main() async {
  runApp(MyApp());
  await AndroidAlarmManager.initialize();
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
      // home: AlarmsPage(title: 'Game Awake!', dtstr: '',),
      home: MyHomePage(title: 'Splash',),
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
  String _strSend = "";

  void getFileString() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
    _strSend = fileContent;
    print(_strSend);
  }

  String getsplashtext(){
    String splashtext = "Splash!";
    getFileString();
    // saveFile();
    return splashtext;
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/DateTimeFile.txt'; // 3
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),() {

      print("reloading");
      print(_strSend);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AlarmsPage(title: 'Game Awake!', dtstr: _strSend)),
      );
    });

    return Scaffold(
      //can remove appBar if you need to
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(getsplashtext()),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}