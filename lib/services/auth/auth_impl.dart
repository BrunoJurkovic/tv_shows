import 'package:flutter/foundation.dart';
import 'package:tv_shows/business_logic/models/user.dart';
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
  Future<User> login(String username, String password) async {
    try {
      final response = await httpService.get(
          request: LoginRequest(username, password)) as Map<String, dynamic>;
      final result = LoginResponse.fromMap(response);
      final user = User(email: username, password: password);

      await storageService.updateToken(result.token);

      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
  }

  @override
  Future logout() async {
    await storageService.updateToken('');
  }
}
