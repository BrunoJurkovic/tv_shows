import 'package:tv_shows/business_logic/models/user.dart';

abstract class LoginService {
  Future<User> login(String username, String password);
  Future logout();
  String getToken();
}
