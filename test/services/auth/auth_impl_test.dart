import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_shows/services/auth/auth.dart';

class AuthImplementationMock extends Mock implements AuthenticationService {}

void main() {
  group(
    'login',
    () {
      setUpAll(
        () {},
      );
      test(
        'should call LoginRequest',
        () {},
      );
    },
  );
}
