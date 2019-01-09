import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_place/entrant.dart';


class LobbyPage extends StatefulWidget {
  LobbyPage({Key key, @required this.entrant}) : super(key: key);

  final Entrant entrant;

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(seconds: 2), (timer) {
      print("asd");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Race placezzz"),
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