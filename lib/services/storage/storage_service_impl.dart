import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

class StorageServiceImpl implements StorageService {
  StorageServiceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  String getToken() {
    final token = _sharedPreferences.get(TOKEN_STRING);
    if (token == null) {
      return '';
    }
    return token.toString();
  }

  @override
  Future<void> updateToken(String token) async {
    await _sharedPreferences.setString(TOKEN_STRING, token);
  }
}
