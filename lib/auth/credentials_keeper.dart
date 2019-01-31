import 'package:race_place/auth/creds.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final CredentialsKeeper credentialsKeeper = CredentialsKeeper._private();

class CredentialsKeeper {

  CredentialsKeeper._private();
  final storage = new FlutterSecureStorage();

  // when we login
  Future<void> save(Creds creds) {
    return storage.write(key: "access_token", value: creds.accessToken);
  }

  // when we logout
  Future<void> clear() {
    return storage.deleteAll();
  }

  // so we know to refresh or what
  bool hasValidCreds() => false;

  // retrieve them if they're not expired. Or refresh
  Future<String> getCredentials() async {
    return storage.read(key: "access_token");
  }

}
