import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/forcast.dart';
import 'package:flutter_app/services/network.dart';
import 'package:flutter_app/services/suggestion.dart';
import 'package:flutter_app/services/weather.dart';
import 'package:flutter_app/services/preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Loading extends StatelessWidget {
  final Preferences preferences = Preferences();

  void getData(context) async {
    final CityCoordinates defaultLocation = preferences.getDefaultLocation();
    final Network network = Network(
      lat: defaultLocation.lat,
      long: defaultLocation.long,
    );
    CurrentWeather cWeather = await network.getCurrentWeather();
    List<ForcastWeather> fWeatherList = await network.getForcastWeather();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            HomePage(
                cWeather: cWeather,
                city: '${defaultLocation.city}, ${defaultLocation.country}'),
            ForcastPage(fWeatherList: fWeatherList),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loading',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('...', speed: Duration(milliseconds: 200)),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
