class User {
  User({
    required this.email,
    required this.password,
    required this.token,
  });

  final String email;
  final String password;
  final String token;

  static Map<String, String> toMap(User user) {
    return {
      'email': user.email,
      'password': user.password,
      'token': user.token,
    };
  }
}
