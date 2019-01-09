// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
      json['status'] as String,
      (json['entrants'] as List)
          ?.map((e) => e == null
              ? null
              : TrackEntrant.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TrackToJson(Track instance) =>
    <String, dynamic>{'status': instance.status, 'entrants': instance.entrants};

TrackEntrant _$TrackEntrantFromJson(Map<String, dynamic> json) {
  return TrackEntrant(
      json['userId'] as String, (json['distance'] as num)?.toDouble());
}

Map<String, dynamic> _$TrackEntrantToJson(TrackEntrant instance) =>
    <String, dynamic>{'userId': instance.userId, 'distance': instance.distance};
