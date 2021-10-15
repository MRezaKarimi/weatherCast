import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_app/services/suggestion.dart';

class Preferences {
  final Map initialLocation = {
    'lat': 51.5074,
    'long': 0.1278,
    'city': 'London',
    'state': '',
    'country': 'UK',
  };

  static Future<void> initiateDB() async {
    await Hive.initFlutter();
    await Hive.openBox('location');
  }

  CityCoordinates getDefaultLocation() {
    var box = Hive.box('location');
    var defaultLocation =
        box.get('defaultLocation', defaultValue: initialLocation);

    return CityCoordinates.fromMap(defaultLocation);
  }

  void setDefaultLocation(CityCoordinates location) {
    var box = Hive.box('location');
    box.put('defaultLocation', location.toMap());
  }
}
