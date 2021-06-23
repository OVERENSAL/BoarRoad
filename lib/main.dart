import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boar_road/main_page.dart';

void main() => runApp(BoarRoad());

class BoarRoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boar Road',
      home: MainPage(),
    );
  }
}
