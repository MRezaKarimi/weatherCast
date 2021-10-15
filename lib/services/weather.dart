class Weather {
  final int id;
  final DateTime dt;
  final String description;

  static const List<String> _weekDays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  Weather({required this.id, required this.description, required int timestamp})
      : this.dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  String getDay() {
    return _weekDays[dt.weekday - 1][0].toUpperCase() +
        _weekDays[dt.weekday - 1].substring(1);
  }

  String getShortDay() {
    return _weekDays[dt.weekday - 1].substring(0, 3).toUpperCase();
  }

  String getHour() {
    if (dt.hour < 13) {
      return '${dt.hour} AM';
    } else {
      return '${dt.hour - 12} PM';
    }
  }

  String getIcon() {
    bool night = dt.hour < 18 ? false : true;
    String icon = 'weather_icons/static/';

    if (id < 300) {
      icon += 'thunder.svg';
    } else if (id < 312) {
      icon += 'rainy-4.svg';
    } else if (id < 399) {
      icon += 'rainy-5.svg';
    } else if (id < 520) {
      icon += 'rainy-6.svg';
    } else if (id < 600) {
      icon += 'rainy-7.svg';
    } else if (id < 602) {
      icon += 'snowy-4.svg';
    } else if (id < 613) {
      icon += 'snowy-5.svg';
    } else if (id < 700) {
      icon += 'snowy-6.svg';
    } else if (id < 800) {
      icon += 'cloudy.svg';
    } else if (id == 800) {
      if (!night) {
        icon += 'day.svg';
      } else {
        icon += 'night.svg';
      }
    } else if (id < 899) {
      if (!night) {
        icon += 'cloudy-day-1.svg';
      } else {
        icon += 'cloudy-night-1.svg';
      }
    }
    return icon;
  }
}

class CurrentWeather extends Weather {
  final int temp;
  final int pressure;
  final int visibility;
  final int windSpeed;
  final int humidity;
  final int clouds;
  final dynamic uv;

  CurrentWeather({
    required int id,
    required int timestamp,
    required String description,
    required this.temp,
    required this.pressure,
    required this.visibility,
    required this.windSpeed,
    required this.humidity,
    required this.clouds,
    required this.uv,
  }) : super(id: id, description: description, timestamp: timestamp);
}

class ForcastWeather extends Weather {
  final int min;
  final int max;

  ForcastWeather(
      {required int id,
      required int timestamp,
      required String description,
      required this.min,
      required this.max})
      : super(id: id, description: description, timestamp: timestamp);
}
