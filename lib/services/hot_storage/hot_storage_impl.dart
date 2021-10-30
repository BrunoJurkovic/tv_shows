import 'package:tv_shows/services/hot_storage/hot_storage.dart';

class HotStorageServiceImpl implements HotStorageService {
  String? _token;

  @override
  String get token => _token ?? '';

  @override
  void updateToken(String token) {
    _token = token;
  }
}
