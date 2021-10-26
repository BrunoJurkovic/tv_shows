abstract class AuthenticationService {
  Future<bool> login(String username, String password);
  Future logout();
}
