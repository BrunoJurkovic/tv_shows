import 'package:tv_shows/business_logic/utils/auth_utils.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  AuthenticationServiceImpl({
    required this.storageService,
    required this.httpService,
  });

  final StorageService storageService;
  final BaseHttpService httpService;

  @override
  Future<bool> login(String username, String password,
      {bool? rememberLogin}) async {
    try {
      final response = await httpService.post(
          request: LoginRequest(username, password)) as Map<String, dynamic>;
      final result = LoginResponse.fromMap(response);

      await storageService.updateToken(result.token);
      if (rememberLogin ?? false) {
        await storageService.updateRememberUser(true);
      } else {
        await storageService.updateRememberUser(false);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future logout() async {
    await storageService.updateToken('');
    await storageService.updateRememberUser(false);
  }
}