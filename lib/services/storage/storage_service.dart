// ignore: constant_identifier_names
const TOKEN_STRING = 'TOKEN_STRING';

abstract class StorageService {
  Future<void> updateToken(String token);
  String getToken();
}
