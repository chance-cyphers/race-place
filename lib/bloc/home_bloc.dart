import 'dart:async';

import 'package:race_place/api/entrant.dart';
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/auth/credentials_keeper.dart';
import 'package:race_place/auth/parser.dart';

class HomeBloc {
  StreamController _startRaceController;
  StreamController<Entrant> _whenEnteredController;
  StreamController<String> _usernameController;
  StreamController _logoutController;

  Sink get newRacer => _startRaceController.sink;

  Sink get logout => _logoutController.sink;

  Stream<Entrant> get whenEntered => _whenEnteredController.stream;

  Stream<String> get username => _usernameController.stream;

  HomeBloc() {
    _startRaceController = new StreamController();
    _logoutController = new StreamController();
    _whenEnteredController = new StreamController();
    _usernameController = new StreamController();

    _startRaceController.stream.listen(_onRace);
    _logoutController.stream.listen(_onLogout);
    _usernameController.onListen = _fetchUsername;
  }

  void _fetchUsername() {
    credentialsKeeper.getCredentials().then((creds) {
      _usernameController.add(getName(creds.idToken));
    });
  }

  void _onRace(_) {
    credentialsKeeper.getCredentials().then((creds) {
      return raceApiClient.createEntrant(getName(creds.idToken));
    }).then((entrant) {
      _whenEnteredController.add(entrant);
    });
  }

  void _onLogout(_) {
    credentialsKeeper.clear();
  }

  void close() {
    _startRaceController.close();
    _whenEnteredController.close();
    _usernameController.close();
    _logoutController.close();
  }
}
