import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/widgets.dart';
import 'package:flutter_app/services/weather.dart';
import 'search.dart';

class HomePage extends StatelessWidget {
  final String city;
  final CurrentWeather cWeather;

  HomePage({required this.cWeather, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      city,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext buildContext) => Search(),
                        ),
                      );
                    },
                    icon: Icon(CupertinoIcons.location),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '${cWeather.getDay()}, ${cWeather.getHour()}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    '${cWeather.getIcon()}',
                    height: 100.0,
                  ),
                  Text(
                    '${cWeather.temp}°',
                    style: TextStyle(fontSize: 60.0),
                  ),
                  Text(
                    '${cWeather.description}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DetailLabel(
                            title: 'Pressure', value: '${cWeather.pressure}mb'),
                        DetailLabel(title: 'UV', value: '${cWeather.uv}'),
                        DetailLabel(
                            title: 'Humidity', value: '${cWeather.humidity}%'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DetailLabel(
                            title: 'Wind', value: '${cWeather.windSpeed}m/s'),
                        DetailLabel(
                            title: 'Visibility',
                            value: cWeather.visibility < 1000
                                ? '${cWeather.visibility}m'
                                : '${cWeather.visibility ~/ 1000}km'),
                        DetailLabel(
                            title: 'Clouds', value: '${cWeather.clouds}%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Icon(CupertinoIcons.chevron_compact_down),
              ),
            )
          ],
        ),
      ),
    );
  }
}
