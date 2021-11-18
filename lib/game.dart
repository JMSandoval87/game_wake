import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:sensors/sensors.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'alarmspage.dart';


class runG extends StatefulWidget {
  final String lastalarm;
  final String title;
  runG({Key? key, required this.title, required this.lastalarm}) : super(key: key);
  runGState createState() => runGState();
}

class runGState extends State<runG> with TickerProviderStateMixin {
  String _strSend = "";
  late Animation<double> bulletAnimation, targetAnimation;
  late AnimationController bulletController, targetController;
  double bulletYPoint = 0,
      targetYPoint = 0,
      bulletXPoint = 0,
      targetXPoint = 0,
      x = 0;
  int count = 1;
  int scoreToBeat = 3;
  int endGame = 0;
  var rand = Random();
  static const Color white = Colors.white;
  static const Color b = Colors.black;
  static const Color red = Colors.redAccent;
  static const Color deepo = Colors.deepOrange;
  static const Color blue = Colors.indigo;
  Widget box = Container(height: 30, width: 30, color: deepo,);
  void init() {
    bulletController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    accelerometerEvents.listen((AccelerometerEvent event) {
      if ((-x * 5 - event.y).abs() > 0.1) {
        if (event.x < -5)
          stream.addValue(1);
        else if (event.x > 5)
          stream.addValue(-1);
        else {
          x = -double.parse(event.x.toStringAsFixed(1)) / 5;
          stream.addValue(x);
        }
      }
    });
    initialize();
  }

  void initialize() {
    bulletYPoint = 1;
    targetYPoint = -1;
    bulletAnimation = Tween(begin: 1.0, end: -1.0).animate(bulletController)
      ..addStatusListener((event) {
        if (event == AnimationStatus.completed) {
          bulletController.reset();
          bulletController.forward();
        }
      })
      ..addListener(() {
        stream.bulletStream.add(bulletAnimation.value);
      });
    bulletController.forward();
    targetController = AnimationController(
        duration: Duration(milliseconds: count < 45 ? 10000 - (count * 200) : 1000),
        vsync: this);
    targetAnimation = Tween(begin: -1.0, end: 1.0).animate(targetController)
      ..addListener(() {
        setState(() {
          targetYPoint = targetAnimation.value;
        });
        if (targetAnimation.value == 1) {
          endGame = 2;
        }
        if (count > scoreToBeat) {
          endGame = 2;
        }
      });
    targetController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (bulletXPoint > targetXPoint - 0.15 && bulletXPoint < targetXPoint + 0.15) {
      if (bulletYPoint < targetYPoint) {
        setState(() {
          count++;
          if (rand.nextBool())
            targetXPoint = rand.nextDouble();
          else
            targetXPoint = -rand.nextDouble();
        });
        bulletController.reset();
        initialize();
      }
    }

    if (endGame == 1 && bulletAnimation.value == 1) {
      bulletXPoint = x;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Stack(children: <Widget>[
        Icon(Icons.arrow_upward),
        Scaffold(
          backgroundColor: Colors.black,
          body: endGame != 1
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Game Wake!",
                    style: TextStyle(color: white, fontSize: 62),
                  ),
                ),
                Text(
                  (count <= scoreToBeat && endGame == 2) ? "Score:${count - 1} \ntry again."
                      : "Score:${count - 1}",
                  style: TextStyle(color: white, fontSize: 62),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(count > scoreToBeat){
                      FlutterRingtonePlayer.stop();
                      count = 1;
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AlarmsPage(title: 'Game Awake!', dtstr: _strSend, lastalarm: widget.lastalarm)),
                      );
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    }
                    else{
                      FlutterRingtonePlayer.playAlarm();
                    }

                    init();
                    endGame = 1;
                    count = 1;
                    initialize();
                  },
                  child: Container(
                      height: 60,
                      width: 60,
                      child: (endGame == 2)
                          ? Icon(Icons.cancel, color: white, size: 62,)
                          : Icon(Icons.play_arrow, color: white, size: 62,)
                  ),
                ),
              ],
            ),
          )
              : Column(
            children: <Widget>[
              Expanded(
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment(0.8, -0.9),
                      child: Text(
                        "${count - 1}",
                        style: TextStyle(fontSize: 32, color: white),
                      ),
                    ),
                    StreamBuilder(
                      initialData: 1.0,
                      stream: stream.bulletStreamGet,
                      builder: (context, stream) {
                        bulletYPoint = stream.data as double;
                        return Align(
                            alignment: Alignment(bulletXPoint, stream.data as double),
                            child:
                            //  Icon(Icons.arrow_upward)
                            Container(
                              width: 15,
                              child: Icon(Icons.arrow_drop_up_rounded, color: red,),
                            ));
                      },
                    ),
                    Align(
                        alignment: Alignment(targetXPoint, targetYPoint),
                        child: Container(
                          width: 40,
                          child:Icon(Icons.brightness_high_outlined, color: deepo, size: 30.0,),
                        ))
                  ])),
              StreamBuilder(
                initialData: 0.0,
                stream: stream.shooterStreamGet,
                builder: (ctx, stream) {
                  x = stream.data as double;
                  return Align(
                    alignment: Alignment(stream.data as double, 1),
                    child: Container(
                      width: 60,
                      height: 30,
                      child: Icon(Icons.navigation_rounded, color: blue, size: 30.0,),
                    ),
                    //box
                  );
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class Streams {
  StreamController shooterStreamController =
  StreamController<double>.broadcast(),
      bulletStreamController = StreamController<double>.broadcast();

  Sink get shooterStream => shooterStreamController.sink;
  Sink get bulletStream => bulletStreamController.sink;

  Stream<double>? get shooterStreamGet => shooterStreamController.stream as dynamic;
  Stream<double>? get bulletStreamGet => bulletStreamController.stream as dynamic;

  addValue(double value) {
    shooterStream.add(value);
  }

  addBulletValue(double value) {
    bulletStream.add(value);
  }

  voiddispose() {
    shooterStreamController.close();
    bulletStreamController.close();
  }
}

Streams stream = Streams();