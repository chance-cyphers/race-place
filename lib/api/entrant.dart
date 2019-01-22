import 'package:json_annotation/json_annotation.dart';

part 'package:race_place/api/entrant.g.dart';

@JsonSerializable()
class CreateEntrantRequest {
  CreateEntrantRequest(this.userId);

  String userId;

  factory CreateEntrantRequest.fromJson(Map<String, dynamic> json) => _$CreateEntrantRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEntrantRequestToJson(this);
}

@JsonSerializable()
class Entrant {
  Entrant(this.userId, this.links);

  String userId;
  Links links;

  factory Entrant.fromJson(Map<String, dynamic> json) => _$EntrantFromJson(json);
  Map<String, dynamic> toJson() => _$EntrantToJson(this);
}

@JsonSerializable()
class Links {
  Links(this.track);

  String track;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}