import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/alarmspage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'game.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Wake!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'GAME WAKE!',),
      // home: AlarmsPage(title: 'Game Awake!', dtstr: '',),
      // home: runG(title: 'Game', lastalarm: "fdsa"),//MyHomePage(title: 'Splash',),
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


  String getImagePath(){
    String imagepath = "assets/gamewakelogo.gif";
    getFileString();
    // saveFile();
    return imagepath;
  }

  String getsplashtext(){
    String splashtext = "GAME WAKE!";
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
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AlarmsPage(title: 'GAME WAKE!', dtstr: _strSend, lastalarm: "")),
      );
    });

    return Scaffold(
      //can remove appBar if you need to
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
        Image.asset(getImagePath() as String),
        // Text(getsplashtext()),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}