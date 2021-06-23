import 'package:flutter/cupertino.dart';

class TimerManager {
  bool timerIsStart = false;
  final setsController = TextEditingController()..text = "21";
  final timeController = TextEditingController()..text = "60";
  int time = 0;

  String getButtonText() {
    if (!timerIsStart) {
      return "Start destroying";
    }
    return "Never give up";
  }

  Color getContainerColor() {
    if (!timerIsStart) {
      return Color(0xFFFFFFFF);
    }
    return Color(0x00000000);
  }

  Color getTextColor() {
    if (!timerIsStart) {
      return Color(0xFF000000);
    }
    return Color(0xFFFFFFFF);
  }


}