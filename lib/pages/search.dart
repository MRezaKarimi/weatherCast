import 'package:flutter/material.dart';
import 'package:flutter_app/pages/loading.dart';
import 'package:flutter_app/widgets.dart';
import 'package:flutter_app/services/suggestion.dart';
import 'package:flutter_app/services/preferences.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<CityCoordinates> suggestionList = [];
  SuggestionHelper helper = SuggestionHelper();
  Preferences preferences = Preferences();

  void getSuggestions(String cityName) async {
    List tmp = await helper.getSuggestionList(cityName);

    clearAllItems();

    tmp.forEach((element) {
      suggestionList.insert(0, element);
      listKey.currentState
          ?.insertItem(0, duration: Duration(milliseconds: 200));
    });
  }

  Widget buildItem(context, index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: SuggestionCard(
        data: suggestionList[index],
        onTap: _showDialog,
      ),
    );
  }

  void clearAllItems() {
    for (var i = 0; i < suggestionList.length; i++) {
      listKey.currentState?.removeItem(0, (context, animation) => Container(),
          duration: Duration(milliseconds: 100));
    }
    suggestionList.clear();
  }

  Future<void> _showDialog(CityCoordinates data) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          title: const Text('Set Default Location'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to set this city as default location?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Set',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                preferences.setDefaultLocation(data);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Loading(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'City',
                  ),
                  onSubmitted: (value) {
                    getSuggestions(value);
                  },
                  autofocus: true,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: AnimatedList(
                key: listKey,
                initialItemCount: 0,
                itemBuilder: (context, index, animation) =>
                    buildItem(context, index, animation),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
