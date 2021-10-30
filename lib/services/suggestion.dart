import 'package:http/http.dart' as http;
import 'dart:convert';

class SuggestionHelper {
  final String appID = '[YOUR APPID]';
  final String api = 'http://api.openweathermap.org/geo/1.0/direct?limit=5';

  Future<List<CityCoordinates>> getSuggestionList(String cityName) async {
    var url = Uri.parse(api + '&q=$cityName&appid=$appID');
    http.Response response = await http.get(url);
    List<CityCoordinates> suggestionList = [];
    var data;

    if (response.statusCode != 200) {
      return suggestionList;
    }

    data = jsonDecode(response.body);

    for (var i = 0; i < data.length; i++) {
      suggestionList.add(
        CityCoordinates(
            lat: data[i]['lat'],
            long: data[i]['lon'],
            city: data[i]['name'],
            state: data[i]['state'] ?? '',
            country: data[i]['country']),
      );
    }

    return suggestionList;
  }
}

class CityCoordinates {
  final num lat;
  final num long;
  final String city;
  final String state;
  final String country;

  CityCoordinates(
      {required this.lat,
      required this.long,
      required this.city,
      required this.state,
      required this.country});

  CityCoordinates.fromMap(Map params)
      : this.lat = params['lat'],
        this.long = params['long'],
        this.city = params['city'],
        this.state = params['state'] ?? '',
        this.country = params['country'];

  Map toMap() {
    return {
      'lat': lat,
      'long': long,
      'city': city,
      'country': country,
    };
  }
}
