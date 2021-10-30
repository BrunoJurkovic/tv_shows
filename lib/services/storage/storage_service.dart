// ignore_for_file: constant_identifier_names
const TOKEN_STRING = 'TOKEN_STRING';
const REMEMBER_USER = 'REMEMBER_USER';

abstract class StorageService {
  Future<void> updateToken(String token);
  String getToken();
}
