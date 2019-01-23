import 'package:flutter/material.dart';

class FinishScreen extends StatelessWidget {

  final String winner;

  FinishScreen({key: Key, @required this.winner});

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
              'The winner is ' + winner + '!',
            ),
          ],
        ),
      ),
    );
  }

}