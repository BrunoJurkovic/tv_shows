abstract class AuthenticationService {
  Future<bool> login(String username, String password, {bool? rememberLogin});
  Future logout();
}
