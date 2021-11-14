import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'alarmspage.dart';


class MG extends StatefulWidget {
  MGState createState() => MGState();
}

class MGState extends State<MG> with TickerProviderStateMixin {
  late Animation<double> bA, tA;
  late AnimationController bC, tC;
  double bYP = 0, tYP = 0, bXP = 0, tXP = 0;
  late double x = 0;
  int c = 1;
  int scoreToBeat = 3;
  int eG = 0;
  var r = Random();
  static const Color w = Colors.white;
  Widget d = Container(height: 30, width: 30, color: Colors.deepOrange,);
  void it() {
    bC =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    accelerometerEvents.listen((AccelerometerEvent e) {


      if ((-x * 5 - e.y).abs() > 0.1) {
        if (e.x < -5)
          s.addValue(1);
        else if (e.x > 5)
          s.addValue(-1);
        else {
          x = double.parse(e.x.toStringAsFixed(1)) / 5;
          s.addValue(x);
        }

      }
    });
    i();
  }

  void i() {
    bYP = 1;
    tYP = -1;
    bA = Tween(begin: 1.0, end: -1.0).animate(bC)
      ..addStatusListener((e) {
        if (e == AnimationStatus.completed) {
          bC.reset();
          bC.forward();
        }
      })
      ..addListener(() {
        s.bS.add(bA.value);
      });
    bC.forward();
    tC = AnimationController(
        duration: Duration(milliseconds: c < 45 ? 10000 - (c * 200) : 1000),
        vsync: this);
    tA = Tween(begin: -1.0, end: 1.0).animate(tC)
      ..addListener(() {
        setState(() {
          tYP = tA.value;
        });
        if (tA.value == 1) {
          eG = 2;
        }

        if (c > scoreToBeat) {
          eG = 2;
        }

      });
    tC.forward();
  }

  @override


  Widget build(BuildContext ctx) {
    if (bXP > tXP - 0.15 && bXP < tXP + 0.15) {
      if (bYP < tYP) {

        setState(() {
          c++;
          if (r.nextBool())
            tXP = r.nextDouble();
          else
            tXP = -r.nextDouble();
        });
        bC.reset();
        i();
      }
    }

    if (eG == 1 && bA.value == 1) {
      bXP = x;
    }

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: eG != 1
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Game Wake!",
                  style: TextStyle(color: w, fontSize: 62),
                ),
              ),
              Text(
                (c <= scoreToBeat && eG == 2) ? "Score:${c - 1} \ntry again." : "Score:${c - 1}",
                style: TextStyle(color: w, fontSize: 62),
              ),
              ElevatedButton(
                onPressed: () {
                  if(c > scoreToBeat){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>

                              AlarmsPage(title: 'Game Awake!', dtstr: "")),
                    );
                  }


                  // if(eG == 2){

                  // }
                    it();
                  eG = 1;
                  c = 1;
                  i();
                },
                child: Icon(
                  (eG == 2) ? Icons.cancel : Icons.play_arrow,
                  color: w,
                  size: 62,
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
                      "${c - 1}",
                      style: TextStyle(fontSize: 32, color: w),
                    ),
                  ),
                  StreamBuilder(
                    initialData: 1.0,
                    stream: s.bSG,
                    builder: (context, s) {
                      bYP = s.data as double;
                      return Align(
                          alignment: Alignment(bXP, s.data as double),
                          child: Icon(Icons.arrow_upward, color: Colors.deepOrange));
                    },
                  ),
                  Align(alignment: Alignment(tXP, tYP), child: d)
                ])),
            StreamBuilder(
              initialData: 0.0,
              stream: s.hSG,
              builder: (ctx, s) {
                x = s.data as double;
                return Align(alignment: Alignment(s.data as double, 1), child: d);
              },
            )
          ],
        ),
      ),
    );
  }
}

class S {
  StreamController hSC = StreamController<double>.broadcast(),
      bSC = StreamController<double>.broadcast();

  Sink get sS => hSC.sink;
  Sink get bS => bSC.sink;

  Stream<double>? get hSG => hSC.stream as dynamic;
  Stream<double>? get bSG => bSC.stream as dynamic;

  addValue(double v) {
    sS.add(v);
  }

  addBulletValue(double v) {
    bS.add(v);
  }

  voiddispose() {
    hSC.close();
    bSC.close();
  }
}
S s = S();