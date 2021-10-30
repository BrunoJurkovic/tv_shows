import 'package:tv_shows/business_logic/utils/auth_utils.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/hot_storage/hot_storage.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  AuthenticationServiceImpl({
    required this.storageService,
    required this.httpService,
    required this.hotStorageService,
  });

  final StorageService storageService;
  final BaseHttpService httpService;
  final HotStorageService hotStorageService;

  @override
  Future<bool> login(String username, String password,
      {bool? rememberLogin}) async {
    try {
      final response = await httpService.post(
          request: LoginRequest(username, password)) as Map<String, dynamic>;
      final result = LoginResponse.fromMap(response);
      hotStorageService.updateToken(result.token);
      if (rememberLogin ?? false) {
        await storageService.updateToken(result.token);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future logout() async {
    hotStorageService.updateToken('');
    await storageService.updateToken('');
  }
}
