import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int hour = 00;
  int min = 00;
  int sec = 00;
  final duration  = const Duration(seconds : 1);

  bool stopTimer = false;
  bool started = true;
  bool stopped = true;

  String timeToDisplay = "";

  Widget timerShow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 20.0),child: Text("HOURS",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18.0,fontFamily: "cursive")),),
            NumberPicker(minValue: 0, maxValue: 23, value: hour, onChanged: (value){setState(() {
              hour = value;
            });})
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 20.0),child: Text("MINUTES",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18.0,fontFamily: "cursive")),),
            NumberPicker(minValue: 0, maxValue: 60, value: min, onChanged: (value){setState(() {
              min = value;
            });})
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 20.0),child: Text("SECONDS",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18.0,fontFamily: "cursive")),),
            NumberPicker(minValue: 0, maxValue: 60, value: sec, onChanged: (value){setState(() {
              sec = value;
            });})
          ],
        )
      ],
    );
  }


  void start(){
    setState(() {
      started = false;
      stopped = false;
    });
    int time = ((hour*3600)+(min*60)+sec);
    Timer.periodic(duration, (Timer t) {
      setState(() {
        if (time<1 || stopTimer){
          t.cancel();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
        }
        else {
          time -= 1;
          timeToDisplay = "Seconds : $time";
        }
      });
    });

  }

  void stop(){
      setState(() {
        started = true;
        stopped = true;
        stopTimer = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Timer",style: TextStyle(fontSize: 25.0,fontFamily: "cursive",fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:   [
          Expanded(flex: 5,child: timerShow(),),
          Expanded(flex:3,child:  Text(timeToDisplay,style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            fontFamily: "cursive",

          ),)),
          Expanded(
            flex: 2,child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: started ? start : null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  )
                ),
                child: const Text("Start"),
              ),
              ElevatedButton(
                onPressed: stopped ? null : stop,
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 27.0,vertical: 10.0),
                    textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    )
                ),
                child: const Text("Stop"),
              )
            ],
          ),
          )
        ],
      ),
    );
  }
}
