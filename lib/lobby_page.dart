import 'package:flutter/material.dart';
import 'package:race_place/entrant.dart';
import 'package:race_place/lobby_bloc.dart';
import 'package:race_place/race_page.dart';

class LobbyPage extends StatefulWidget {
  LobbyPage({Key key, @required this.entrant}) : super(key: key);

  final Entrant entrant;

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  LobbyBloc _lobbyBloc;

  @override
  void initState() {
    super.initState();
    _lobbyBloc = LobbyBloc(widget.entrant);
    _lobbyBloc.matchFound.listen((matchFound) {
      if (matchFound) {
        gotoRace();
      }
    });
  }

  void gotoRace() {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            maintainState: false,
            builder: (BuildContext buildContext) => RacePage()),
        ModalRoute.withName("/"));
  }

  @override
  void dispose() {
    super.dispose();
    _lobbyBloc.close();
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