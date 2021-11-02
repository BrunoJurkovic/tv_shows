import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/exceptions/exceptions.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

import 'login_viewmodel_test.mocks.dart';

@GenerateMocks([AuthenticationService, StorageService])
void main() {
  late MockAuthenticationService authService;
  late MockStorageService storageService;
  late LoginViewModel viewModel;

  setUpAll(() {
    authService = MockAuthenticationService();
    storageService = MockStorageService();
  });

  group('login()', () {
    test(
      'should login with authenticated LoginStatus',
      () async {
        // arrange
        viewModel = LoginViewModel(
          authenticationService: authService,
          storageService: storageService,
        );
        when(authService.login(any, any)).thenAnswer((_) async => true);
        // act
        await viewModel.login('', '');
        final loginStatus = viewModel.loginStatus;
        // assert
        expect(loginStatus, LoginStatus.authenticated);
      },
    );
    test(
      'should throw HttpException  on wrong details',
      () async {
        // arrange
        viewModel = LoginViewModel(
          authenticationService: authService,
          storageService: storageService,
        );
        when(authService.login(any, any)).thenAnswer((_) async => false);
        // assert
        expect(viewModel.login('', ''), throwsA(isA<HttpException>()));
      },
    );
  });
  group(
    'autoLogin()',
    () {
      test(
        'should autologin successfuly',
        () async {
          // arrange
          viewModel = LoginViewModel(
            authenticationService: authService,
            storageService: storageService,
          );
          when(storageService.getToken())
              .thenAnswer((realInvocation) => 'token');
          // act
          await viewModel.autoLogin();
          final status = viewModel.loginStatus;
          // assert
          expect(status, LoginStatus.authenticated);
        },
      );
      test(
        'should not autologin when token is empty',
        () async {
          // arrange
          viewModel = LoginViewModel(
            authenticationService: authService,
            storageService: storageService,
          );
          when(storageService.getToken()).thenAnswer((realInvocation) => '');
          // act
          await viewModel.autoLogin();
          final status = viewModel.loginStatus;
          // assert
          expect(status, LoginStatus.unauthenticated);
        },
      );
    },
  );
  test(
    'should return token when calling the token getter',
    () async {
      // arrange
      when(storageService.getToken()).thenAnswer((realInvocation) => 'token');
      // act
      final token = viewModel.token;
      // assert
      expect(token, 'token');
    },
  );

  test(
    'should logout with no errors',
    () async {
      // arrange
      viewModel = LoginViewModel(
        authenticationService: authService,
        storageService: storageService,
      );
      when(authService.logout()).thenAnswer((realInvocation) async {});
      // act
      await viewModel.logout();
      final status = viewModel.loginStatus;
      // assert
      expect(status, LoginStatus.unauthenticated);
    },
  );
}
