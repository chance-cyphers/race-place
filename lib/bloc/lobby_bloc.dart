import 'dart:async';

import 'package:race_place/entrant.dart';
import 'package:race_place/race_api_client.dart';

class LobbyBloc {
  StreamController<bool> _matchFoundController;
  Timer _timer;
  Entrant _entrant;

  Stream<bool> get matchFound => _matchFoundController.stream;

  LobbyBloc(this._entrant) {
    _matchFoundController = StreamController<bool>();
    _matchFoundController.onListen = _start;
  }

  void _start() {
    _timer = Timer.periodic(new Duration(seconds: 2), (timer) {
      raceApiClient.getTrack(_entrant.links.track).then((track) {
        if (track.status == "started") {
          _matchFoundController.add(true);
          timer.cancel();
        }
      });
    });
  }

  void close() {
    _timer.cancel();
    _matchFoundController.close();
  }

}