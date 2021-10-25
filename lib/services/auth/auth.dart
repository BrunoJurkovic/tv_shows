import 'package:tv_shows/business_logic/models/user.dart';

abstract class AuthenticationService {
  Future<User> login(String username, String password);
  Future logout();
}
