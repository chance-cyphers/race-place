import 'package:json_annotation/json_annotation.dart';

part 'entrant.g.dart';

@JsonSerializable()
class CreateEntrantRequest {
  CreateEntrantRequest(this.userId);

  String userId;

  factory CreateEntrantRequest.fromJson(Map<String, dynamic> json) => _$CreateEntrantRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEntrantRequestToJson(this);
}

@JsonSerializable()
class CreateEntrantResponse {
  CreateEntrantResponse(this.userId, this.links);

  String userId;
  Links links;

  factory CreateEntrantResponse.fromJson(Map<String, dynamic> json) => _$CreateEntrantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEntrantResponseToJson(this);
}

@JsonSerializable()
class Links {
  Links(this.locationUpdate, this.self);

  String locationUpdate;
  String self;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}