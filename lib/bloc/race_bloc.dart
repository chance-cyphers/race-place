import 'dart:async';

import 'package:race_place/api/location.dart';
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/bloc/location_source.dart';

class RaceBloc {
  StreamController<RaceInfo> _raceInfoController;
  StreamController<String> _winnerController;
  StreamSubscription<Coordinates> _locationSubscription;
  LocationEventSource _locEventSource;
  Track _track;
  Timer _timer;

  Stream<RaceInfo> get model => _raceInfoController.stream;
  Stream<String> get winner => _winnerController.stream;

  RaceBloc(this._track) {
    _raceInfoController = StreamController<RaceInfo>();
    _raceInfoController.onListen = _startLocUpdates;
    _winnerController = StreamController<String>();
    _locEventSource = LocationEventSource();
  }

  void _startLocUpdates() {
    _locationSubscription = _locEventSource.currentLoc.listen((coords) {
      var currentLoc = Location(213, coords.lat, coords.lon);
      raceApiClient
          .updateLocation(_track.links.locationUpdate, currentLoc)
          .then((loc) {})
          .catchError((err) {
        print("ERROR UPDATING LOCATION: " + err);
      });
    });

    _timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      raceApiClient.getTrack(_track.links.self).then(_handleNewTrack);
    });
  }

  void _handleNewTrack(track) {
    var entrant1 = track.entrants[0];
    var entrant2 = track.entrants[1];
    var label1 = entrant1.userId + ": " + entrant1.distance.toString();
    var label2 = entrant2.userId + ": " + entrant2.distance.toString();
    var model = RaceInfo(label1, label2, entrant1.distance, entrant2.distance);
    _raceInfoController.add(model);

    if (track.winner != null && track.winner != "") {
      _winnerController.add(track.winner);
    }
  }

  void close() {
    _locEventSource.close();
    _locationSubscription.cancel();
    _winnerController.close();
    _timer.cancel();
  }
}

class RaceInfo {
  String label1;
  String label2;
  double progress1;
  double progress2;

  RaceInfo(this.label1, this.label2, this.progress1, this.progress2);
}
