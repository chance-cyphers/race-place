import 'package:flutter/material.dart';
import 'package:race_place/page/lobby_page.dart';
import 'package:race_place/api/race_api_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _usernameController = TextEditingController();

  void _onPress(BuildContext context) {
    var isEmpty =
        _usernameController.text.isEmpty || _usernameController.text == null;
    var username = isEmpty ? "Placeholder Johnson" : _usernameController.text;
    raceApiClient.createEntrant(username).then((entrant) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext buildContext) => LobbyPage(entrant: entrant)));
    });
  }

  void dispose() {
    _usernameController.dispose();
    super.dispose();
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
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: "Enter a username"),
            ),
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
