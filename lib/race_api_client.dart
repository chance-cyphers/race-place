import 'package:http/http.dart' as http;
import 'package:race_place/entrant.dart';
import 'dart:convert';

import 'package:race_place/track.dart';

final RaceApiClient raceApiClient = new RaceApiClient._private();

class RaceApiClient {
  RaceApiClient._private();

  static const String host = "http://race-apu.herokuapp.com";

  Future<Entrant> createEntrant(String userId) {
    var body = new CreateEntrantRequest(userId);
    var json = jsonEncode(body.toJson());
    const headers = {"Content-Type": "application/json"};
    const url = host + "/v2/entrant";

    return http.post(url, body: json, headers: headers).then((response) {
      return Entrant.fromJson(jsonDecode(response.body));
    }).catchError((err) {
      print("ERROR: ${err.toString()}");
    });
  }

  Future<Track> getTrack(String trackLink) {
    return http.get(trackLink).then((response) {
      return Track.fromJson(jsonDecode(response.body));
    }).catchError((err) {
      print("ERROR: ${err.toString()}");
    });
  }
}
