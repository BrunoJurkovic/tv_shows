import 'package:tv_shows/business_logic/models/user.dart';
import 'package:tv_shows/business_logic/utils/auth_utils.dart';
import 'package:tv_shows/services/auth/auth.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  AuthenticationServiceImpl(this._loginRequest);

  final LoginRequest _loginRequest;

  @override
  Future<User> login(String username, String password) async {
    throw UnimplementedError();
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
