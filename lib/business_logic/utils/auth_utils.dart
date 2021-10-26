import 'package:tv_shows/services/http/http_service.dart';

class LoginResponse {
  const LoginResponse({required this.token});

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      // ignore: avoid_dynamic_calls
      token: map['data']['token'] as String,
    );
  }

  final String token;
}

class LoginRequest extends BaseHttpPostRequest {
  const LoginRequest(this.username, this.password)
      : super(endpoint: '/api/users/sessions');

  final String username, password;

  @override
  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': username,
      'password': password,
    } as Map<String, dynamic>;
  }
}
