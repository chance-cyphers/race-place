import 'package:flutter/material.dart';
import 'package:race_place/race_api_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Race Place',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void _onPress(BuildContext context) {
    raceApiClient.createEntrant("placeholderJohnson").then((entrant) {
      print("TRACK link: ${entrant.links.track}");
//    Navigator.of(context).push(new MaterialPageRoute(
//        builder: (BuildContext buildContext) => LobbyPage()));
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

class LobbyPage extends StatelessWidget {
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
              'Finding match...',
            ),
          ],
        ),
      ),
    );
  }
}
