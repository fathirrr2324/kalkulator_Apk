import 'package:flutter/material.dart';
import 'package:kalkulator_apk/pages/home.dart';
void main() => runApp(KalkulatorApp());

class KalkulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: KalkulatorHome(),
    );
  }
}
