import 'dart:async';

import 'package:race_place/api/entrant.dart';
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/api/track.dart';

class LobbyBloc {
  StreamController<bool> _matchFoundController;
  StreamController<Track> _trackStartedController;
  Timer _timer;
  Entrant _entrant;

  Stream<bool> get matchFound => _matchFoundController.stream;
  Stream<Track> get trackStarted => _trackStartedController.stream;

  LobbyBloc(this._entrant) {
    _matchFoundController = StreamController<bool>();
    _matchFoundController.onListen = _start;
  }

  void _start() {
    _timer = Timer.periodic(new Duration(seconds: 2), (timer) {
      raceApiClient.getTrack(_entrant.links.track).then((track) {
        if (track.status == "started") {
          _matchFoundController.add(true);
          _trackStartedController.add(track);
          timer.cancel();
        }
      });
    });
  }

  void close() {
    _timer.cancel();
    _matchFoundController.close();
    _trackStartedController.close();
  }

}