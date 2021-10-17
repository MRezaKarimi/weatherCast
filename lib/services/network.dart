import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';

class Network {
  var _data;
  final num lat;
  final num long;
  final String appID = '[YOUR APPID]';
  final String api =
      'https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,minutely,alerts&units=metric';

  Network({required this.lat, required this.long});

  Future<int> _getData() async {
    var url = Uri.parse(api + '&lat=$lat&lon=$long&appid=$appID');
    http.Response response = await http.get(url);

    _data = jsonDecode(response.body);
    return response.statusCode;
  }

  Future<CurrentWeather> getCurrentWeather() async {
    if (_data == null) {
      int statusCode = await _getData();
      if (statusCode != 200) {
        print('error');
      }
    }

    CurrentWeather currentWeather = CurrentWeather(
      timestamp: _data['current']['dt'],
      temp: _data['current']['temp'].toInt(),
      uv: _data['current']['uvi'],
      clouds: _data['current']['clouds'],
      pressure: _data['current']['pressure'],
      humidity: _data['current']['humidity'],
      windSpeed: _data['current']['wind_speed'].toInt(),
      visibility: _data['current']['visibility'],
      description: _data['current']['weather'][0]['main'],
      id: _data['current']['weather'][0]['id'],
    );

    return currentWeather;
  }

  Future<List<ForcastWeather>> getForcastWeather() async {
    if (_data == null) {
      int statusCode = await _getData();
      if (statusCode != 200) {
        print('error');
      }
    }

    List<ForcastWeather> forcastWeathers = [];

    List daily = _data['daily'];
    daily.forEach((element) {
      forcastWeathers.add(ForcastWeather(
        timestamp: element['dt'],
        id: element['weather'][0]['id'],
        description: element['weather'][0]['main'],
        min: element['temp']['min'].toInt(),
        max: element['temp']['max'].toInt(),
      ));
    });

    return forcastWeathers;
  }
}
