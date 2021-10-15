import 'package:flutter/material.dart';
import 'package:flutter_app/pages/loading.dart';
import 'package:flutter_app/services/preferences.dart';

void main() async {
  await Preferences.initiateDB();
  runApp(WeatherCast());
}

class WeatherCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherCast',
      home: Loading(),
    );
  }
}
