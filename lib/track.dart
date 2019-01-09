import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  Track(this.status, this.entrants);

  String status;
  List<TrackEntrant> entrants;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}

@JsonSerializable()
class TrackEntrant {
  TrackEntrant(this.userId, this.distance);

  String userId;
  double distance;

  factory TrackEntrant.fromJson(Map<String, dynamic> json) => _$TrackEntrantFromJson(json);
}