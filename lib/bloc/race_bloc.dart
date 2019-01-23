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
          .then((loc) {
      }).catchError((err) {
        print("ERROR UPDATING LOCATION: " + err);
      });
    });

    _timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      raceApiClient.getTrack(_track.links.self).then((track) {
        var vm = RaceInfo(track.entrants[0], track.entrants[1]);
        _raceInfoController.add(vm);

        if (track.winner != null && track.winner != "") {
          _winnerController.add(track.winner);
        }
      });
    });
  }

  void close() {
    _locEventSource.close();
    _locationSubscription.cancel();
    _winnerController.close();
    _timer.cancel();
  }
}

class RaceInfo {
  TrackEntrant entrant1;
  TrackEntrant entrant2;
  RaceInfo(this.entrant1, this.entrant2);
}