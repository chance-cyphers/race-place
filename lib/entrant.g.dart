// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEntrantRequest _$CreateEntrantRequestFromJson(Map<String, dynamic> json) {
  return CreateEntrantRequest(json['userId'] as String);
}

Map<String, dynamic> _$CreateEntrantRequestToJson(
        CreateEntrantRequest instance) =>
    <String, dynamic>{'userId': instance.userId};

CreateEntrantResponse _$CreateEntrantResponseFromJson(
    Map<String, dynamic> json) {
  return CreateEntrantResponse(
      json['userId'] as String,
      json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CreateEntrantResponseToJson(
        CreateEntrantResponse instance) =>
    <String, dynamic>{'userId': instance.userId, 'links': instance.links};

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(json['locationUpdate'] as String, json['self'] as String);
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'locationUpdate': instance.locationUpdate,
      'self': instance.self
    };
