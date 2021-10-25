abstract class AuthenticationService {
  Future<void> login(String username, String password);
  Future logout();
}
