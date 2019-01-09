import 'package:flutter/material.dart';
import 'package:race_place/lobby_page.dart';
import 'package:race_place/race_api_client.dart';

class HomePage extends StatelessWidget {

  void _onPress(BuildContext context) {
    raceApiClient.createEntrant("placeholderJohnson").then((entrant) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext buildContext) => LobbyPage(entrant: entrant)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Race place"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Welcome to race place',
            ),
            RaisedButton(
              child: Text("Race"),
              onPressed: () {
                _onPress(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

