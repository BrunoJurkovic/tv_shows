import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

class StorageServiceImpl implements StorageService {
  StorageServiceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  String getToken() {
    final token = _sharedPreferences.get(TOKEN_STRING);
    return token.toString();
  }

  @override
  Future<void> updateToken(String token) async {
    await _sharedPreferences.setString(TOKEN_STRING, token);
  }

  @override
  bool rememberUser() {
    return _sharedPreferences.getBool(REMEMBER_USER) ?? false;
  }

  @override
  Future<void> updateRememberUser(bool rememberUser) async {
    await _sharedPreferences.setBool(REMEMBER_USER, rememberUser);
  }
}
