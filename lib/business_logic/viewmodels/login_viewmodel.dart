import 'package:flutter/foundation.dart';
import 'package:tv_shows/business_logic/models/user.dart';
import 'package:tv_shows/services/auth/auth.dart';

enum LoginStatus {
  logedIn,
  logedOut,
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.authenticationService});

  final AuthenticationService authenticationService;

  final _user = User(email: '', password: '');
  LoginStatus? _loginStatus;

  LoginStatus get loginStatus => _loginStatus ?? LoginStatus.logedOut;

  User get user => _user;

  Future<void> login(String username, String password) async {
    try {
      await authenticationService.login(username, password);
      _loginStatus = LoginStatus.logedIn;
      notifyListeners();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  Future<void> logout() async {
    try {
      await authenticationService.logout();
      _loginStatus = LoginStatus.logedOut;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
