import 'dart:async';

import 'package:race_place/api/location.dart';
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/bloc/location_source.dart';

class RaceBloc {
  StreamController<Coordinates> _updatedLocController;
  StreamSubscription<Coordinates> _locationSubscription;
  LocationEventSource _locEventSource;
  Track _track;

  Stream<Coordinates> get updatedLoc => _updatedLocController.stream;

  RaceBloc(this._track) {
    _updatedLocController = StreamController<Coordinates>();
    _updatedLocController.onListen = _startLocUpdates;
    _locEventSource = LocationEventSource();
  }

  void _startLocUpdates() {
    _locationSubscription = _locEventSource.currentLoc.listen((coords) {
      var currentLoc = Location(213, coords.lat, coords.lon);
      raceApiClient
          .updateLocation(_track.links.locationUpdate, currentLoc)
          .then((loc) {
        print("loc update working...");
        _updatedLocController.add(Coordinates(loc.lat, loc.lon));
      }).catchError((err) {
        print("A BIG OLE ERROR: " + err);
      });
    });
  }

  void close() {
    _locEventSource.close();
    _updatedLocController.close();
    _locationSubscription.cancel();
  }
}