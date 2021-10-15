import 'package:flutter/material.dart';
import 'package:flutter_app/services/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForcastPage extends StatelessWidget {
  final List<ForcastWeather> fWeatherList;

  ForcastPage({required this.fWeatherList});

  TableRow _buildRow(ForcastWeather fWeather) {
    return TableRow(
      children: <Widget>[
        Text(
          fWeather.getShortDay(),
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[600],
          ),
        ),
        Text(
          '${fWeather.max}°',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text(
          '${fWeather.min}°',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[600],
          ),
        ),
        SvgPicture.asset(
          fWeather.getIcon(),
          height: 50.0,
        ),
        Text(
          fWeather.description,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final forcastItems = <TableRow>[];

    fWeatherList.forEach((element) {
      forcastItems.add(_buildRow(element));
    });

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  'This Week',
                  style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: forcastItems,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
