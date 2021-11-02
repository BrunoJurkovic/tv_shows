import 'package:flutter/foundation.dart';
import 'package:tv_shows/business_logic/exceptions/exceptions.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

enum LoginStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required this.authenticationService,
    required this.storageService,
  });

  final AuthenticationService authenticationService;
  final StorageService storageService;

  LoginStatus _loginStatus = LoginStatus.initial;

  LoginStatus get loginStatus => _loginStatus;

  String get token => storageService.getToken();

  Future<void> login(
    String username,
    String password, {
    bool? rememberLogin,
  }) async {
    try {
      final response = await authenticationService.login(
        username,
        password,
        rememberLogin: rememberLogin,
      );
      if (response) {
        _loginStatus = LoginStatus.authenticated;
        notifyListeners();
      } else {
        _loginStatus = LoginStatus.unauthenticated;
        notifyListeners();
        throw HttpException();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> autoLogin() async {
    if (_loginStatus == LoginStatus.initial) {
      if (token.isNotEmpty) {
        _loginStatus = LoginStatus.authenticated;
        return;
      }
      _loginStatus = LoginStatus.unauthenticated;
      return;
    }
  }

  Future<void> logout() async {
    await authenticationService.logout();
    _loginStatus = LoginStatus.unauthenticated;
    notifyListeners();
  }
}
