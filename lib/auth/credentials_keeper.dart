import 'dart:async';

import 'package:race_place/auth/creds.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final CredentialsKeeper credentialsKeeper = CredentialsKeeper._private();

class CredentialsKeeper {
  CredentialsKeeper._private();

  final storage = new FlutterSecureStorage();

  Future<void> save(Creds creds) {
    return storage.write(key: "credentials", value: creds.toJson());
  }

  Future<void> clear() {
    return storage.deleteAll();
  }

  Future<bool> hasValidCreds() async {
    var json = await storage.read(key: "credentials");
    if (json == null) {
      return false;
    }

    var creds = Creds.fromJson(json);

    if (creds.accessToken == null) {
      return false;
    }

    var expiration = Duration(minutes: creds.expiresIn);
    if (expiration < Duration(minutes: 10)) {
      return false;
    }

    return true;
  }

  Future<Creds> getCredentials() async {
    return storage.read(key: "credentials").then((json) {
      return Creds.fromJson(json);
    });
  }

}
