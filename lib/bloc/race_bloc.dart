import 'dart:async';

import 'package:race_place/api/location.dart';
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/bloc/location_source.dart';

class RaceBloc {
//  StreamController<Coordinates> _updatedLocController;
  StreamController<Track> _updatedTrackController;
  StreamSubscription<Coordinates> _locationSubscription;
  LocationEventSource _locEventSource;
  Track _track;
  Timer _timer;

//  Stream<Coordinates> get updatedLoc => _updatedLocController.stream;
  Stream<Track> get updatedTrack => _updatedTrackController.stream;

  RaceBloc(this._track) {
//    _updatedLocController = StreamController<Coordinates>();
    _updatedTrackController = StreamController<Track>();
    _updatedTrackController.onListen = _startLocUpdates;
//    _updatedLocController.onListen = _startLocUpdates;
    _locEventSource = LocationEventSource();
  }

  void _startLocUpdates() {
    _locationSubscription = _locEventSource.currentLoc.listen((coords) {
      var currentLoc = Location(213, coords.lat, coords.lon);
      raceApiClient
          .updateLocation(_track.links.locationUpdate, currentLoc)
          .then((loc) {
        print("loc update working...");
      }).catchError((err) {
        print("A BIG OLE ERROR: " + err);
      });
    });

    _timer = Timer.periodic(new Duration(seconds: 2), (timer) {
      raceApiClient.getTrack(_track.links.self).then((track) {
        _updatedTrackController.add(track);
      });
    });

  }

  void close() {
    _locEventSource.close();
//    _updatedLocController.close();
    _locationSubscription.cancel();
    _timer.cancel();
  }
}