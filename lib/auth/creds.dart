import 'dart:convert';

class Creds {
  String idToken;
  String accessToken;
  String refreshToken;
  int expiresIn;

  Creds(this.accessToken, this.refreshToken, this.idToken, this.expiresIn);

  factory Creds.fromJson(String json) {
    var map = jsonDecode(json);
    return Creds(map['access_token'], map['refresh_token'], map['id_token'],
        map['expires_in']);
  }

  String toJson() {
    var map = <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
      "id_token": idToken,
      "expires_in": expiresIn
    };
    return jsonEncode(map);
  }
}
