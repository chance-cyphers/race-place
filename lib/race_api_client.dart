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
    var body = new CreateEntrantRequest(userId);
    var json = jsonEncode(body.toJson());
    const url = _host + "/v2/entrant";

    return http.post(url,body: json, headers: {"Content-Type": "application/json"}).then((response) {
      return Entrant.fromJson(jsonDecode(response.body));
    }).catchError(_printError);
  }

  Future<Track> getTrack(String trackLink) {
    return http.get(trackLink).then((response) {
      return Track.fromJson(jsonDecode(response.body));
    }).catchError(_printError);
  }

  Future<Location> updateLocation(String locLink, Location loc) {
    var json = jsonEncode(loc.toJson());
    return http.post(locLink, body: json ,headers: {"Content-Type": "application/json"}).then((response) {
      print("resp: ${response.toString()}");
    }).catchError(_printError);
  }

  void _printError(Object err) {
    print("ERROR: ${err.toString()}");
  }
}
