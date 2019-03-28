import 'package:flutter/material.dart';
import 'package:race_place/auth/credentials_keeper.dart';
import 'package:race_place/auth/parser.dart';
import 'package:race_place/page/lobby_page.dart';
import 'package:race_place/api/race_api_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var username = "whoever you are";

  void _onPress(BuildContext context) {
    raceApiClient.createEntrant(username).then((entrant) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext buildContext) => LobbyPage(entrant: entrant)));
    });
  }

  void _onLogout(BuildContext context) {
    credentialsKeeper.clear();
  }

  @override
  void initState() {
    super.initState();
    credentialsKeeper.getCredentials().then((creds) {
      setState(() {
        username = getName(creds.idToken);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Race place"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                _onLogout(context);
              },
            ),
            Text(
              'Welcome to race place, ' + username,
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
