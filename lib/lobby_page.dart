import 'package:flutter/material.dart';
import 'package:race_place/entrant.dart';

class LobbyPage extends StatelessWidget {
  LobbyPage({Key key, @required this.entrant}) : super(key: key);

  final Entrant entrant;

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
              'Finding match for ${entrant.userId}...',
            ),
          ],
        ),
      ),
    );
  }
}
