import 'package:flutter/foundation.dart';
import 'package:tv_shows/business_logic/models/user.dart';
import 'package:tv_shows/services/auth/auth.dart';

enum LoginStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.authenticationService});

  final AuthenticationService authenticationService;

  final _user = User(email: '', password: '');
  LoginStatus _loginStatus = LoginStatus.initial;

  LoginStatus get loginStatus => _loginStatus;

  User get user => _user;

  Future<void> login(String username, String password) async {
    try {
      final response = await authenticationService.login(username, password);
      if (response) {
        _loginStatus = LoginStatus.authenticated;
        print(_loginStatus);
        notifyListeners();
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await authenticationService.logout();
      _loginStatus = LoginStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
