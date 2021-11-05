import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/alarmspage.dart';
import 'package:flutter_app/set_alarm.dart';
import 'package:flutter_app/settings.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


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
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),() {
      print("reloading");
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AlarmsPage(title: 'Game Awake!', dtstr: "")),
      );
    });

    return Scaffold(
      //can remove appBar if you need to
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Splash Screen'),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}