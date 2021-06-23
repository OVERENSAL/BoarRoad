import 'dart:async';

import 'package:boar_road/timer_manager.dart';
import 'package:boar_road/timer_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainPage extends StatefulWidget {
  final TimerManager timerManager = TimerManager();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TimerNotification timerNotification = TimerNotification();
  late Timer _timer;
  int time = 0;

  @override
  void initState() {
    timerNotification.initializeSettings();
    super.initState();
  }

  void _startTimer() {
    widget.timerManager.timerIsStart = true;
    int sets = int.parse(widget.timerManager.setsController.text);
    time = int.parse(widget.timerManager.timeController.text);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time == 0) {
          timerNotification.showNextSetNotification();
          if (sets == 1) {
            _stopTimer();
            timerNotification.showEndTrainingSessionNotification();
          } else {
            time = int.parse(widget.timerManager.timeController.text);
            sets--;
          }
        } else {
          time--;
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      time = 0;
    });
    widget.timerManager.timerIsStart = false;
    _timer.cancel();
  }

  double getPercentageOfElapsedTime() {
    return 1 - (time / int.parse(widget.timerManager.timeController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.blue]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Destroy IT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
            ),
            CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              percent: getPercentageOfElapsedTime(),
              animation: true,
              animateFromLastPercent: true,
              radius: 250.0,
              lineWidth: 15.0,
              backgroundColor: Colors.white,
              progressColor: Colors.deepOrange,
              center: Text(
                time.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
              child: Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: widget.timerManager.getContainerColor(),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sets",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: widget.timerManager.getTextColor(),
                            ),
                          ),
                          TextFormField(
                            enabled: !widget.timerManager.timerIsStart,
                            controller: widget.timerManager.setsController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: widget.timerManager.getTextColor(),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: widget.timerManager.getTextColor(),
                            ),
                          ),
                          TextFormField(
                            enabled: !widget.timerManager.timerIsStart,
                            controller: widget.timerManager.timeController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: widget.timerManager.getTextColor(),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                child: Text(
                  widget.timerManager.getButtonText(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (widget.timerManager.timerIsStart) {
                    _stopTimer();
                  } else {
                    _startTimer();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
