import 'package:flutter/material.dart';
import 'package:flutter_app/services/suggestion.dart';

class DetailLabel extends StatelessWidget {
  DetailLabel({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final CityCoordinates data;
  final void Function(CityCoordinates data) onTap;

  SuggestionCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(data);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[200],
        ),
        width: 1000,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          '${data.city} ${data.state}, ${data.country}',
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
