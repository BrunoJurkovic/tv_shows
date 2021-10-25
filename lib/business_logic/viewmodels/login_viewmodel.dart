import 'package:flutter/foundation.dart';
import 'package:tv_shows/business_logic/models/user.dart';
import 'package:tv_shows/services/auth/auth.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.authenticationService});

  final AuthenticationService authenticationService;

  final _user = User(email: '', password: '');

  User get user => _user;

  Future<void> login(String username, String password) async {
    try {
      final result = await authenticationService.login(username, password);

      notifyListeners();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
