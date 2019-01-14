import 'package:http/http.dart' as http;
import 'package:race_place/entrant.dart';
import 'package:race_place/location.dart';
import 'dart:convert';

import 'package:race_place/track.dart';

final RaceApiClient raceApiClient = new RaceApiClient._private();

class RaceApiClient {
  RaceApiClient._private();

  static const String _host = "http://race-apu.herokuapp.com";

  Future<Entrant> createEntrant(String userId) {
    var json = jsonEncode(new CreateEntrantRequest(userId).toJson());
    return _post(_host + "/v2/entrant", json).then((response) {
      return Entrant.fromJson(jsonDecode(response.body));
    });
  }

  Future<Track> getTrack(String trackLink) {
    return http.get(trackLink).then((response) {
      return Track.fromJson(jsonDecode(response.body));
    }).catchError(_printError);
  }

  Future<Location> updateLocation(String locLink, Location loc) {
    return _post(locLink, jsonEncode(loc.toJson())).then((response) {
      print("resp: ${response.toString()}");
    });
  }

  Future<http.Response> _post(String url, String json) {
    return http.post(url,
        body: json,
        headers: {"Content-Type": "application/json"}).catchError((err) {
      print("ERROR: ${err.toString()}");
    });
  }

  void _printError(Object err) {}
}
