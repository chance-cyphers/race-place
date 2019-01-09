import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_place/entrant.dart';
import 'package:race_place/race_api_client.dart';

class LobbyPage extends StatefulWidget {
  LobbyPage({Key key, @required this.entrant}) : super(key: key);

  final Entrant entrant;

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(new Duration(seconds: 2), (timer) {
      raceApiClient.getTrack(widget.entrant.links.track).then((track) {
        if (track.status == "started") {
          Navigator.of(context).push(new MaterialPageRoute(
              maintainState: false,
              builder: (BuildContext buildContext) => RacePage()));
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
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
              'Finding match for ${widget.entrant.userId}...',
            ),
          ],
        ),
      ),
    );
  }
}

class RacePage extends StatelessWidget {
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
              'You are racing now. Just so you know.',
            ),
          ],
        ),
      ),
    );
  }
}
