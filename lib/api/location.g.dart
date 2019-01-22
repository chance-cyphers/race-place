// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(json['time'] as int, (json['lat'] as num)?.toDouble(),
      (json['lon'] as num)?.toDouble());
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'time': instance.time,
      'lat': instance.lat,
      'lon': instance.lon
    };
