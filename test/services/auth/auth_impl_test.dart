// ignore_for_file: avoid_dynamic_calls

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/utils/auth_utils.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/auth/auth_impl.dart';
import 'package:tv_shows/services/hot_storage/hot_storage.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

import 'auth_impl_test.mocks.dart';

@GenerateMocks([
  StorageService,
  BaseHttpService,
  HotStorageService,
  LoginRequest,
])
void main() {
  late AuthenticationService authenticationService;
  late StorageService storageService;
  late MockBaseHttpService httpService;
  late HotStorageService hotStorageService;

  setUpAll(
    () {
      storageService = MockStorageService();
      httpService = MockBaseHttpService();
      hotStorageService = MockHotStorageService();
      authenticationService = AuthenticationServiceImpl(
        storageService: storageService,
        httpService: httpService,
        hotStorageService: hotStorageService,
      );
    },
  );
  group(
    'login',
    () {
      final resultMap = <String, dynamic>{
        'data': {
          'token': '',
        }
      };
      test(
        'should return true when login successful',
        () async {
          when(
            httpService.post(request: anyNamed('request')),
          ).thenAnswer(
            (realInvocation) async => resultMap,
          );
          final result = authenticationService.login('a', 'a');
          expect(await result, true);
        },
      );
      test(
        'should return false when login unsuccessful',
        () async {
          when(
            httpService.post(request: anyNamed('request')),
          ).thenThrow(
            Exception(),
          );
          final result = authenticationService.login('a', 'a');
          expect(await result, false);
        },
      );
      test(
        'should save token to storage if rememberLogin is true',
        () async {
          when(
            httpService.post(request: anyNamed('request')),
          ).thenAnswer(
            (realInvocation) async => resultMap,
          );
          await authenticationService.login('a', 'a', rememberLogin: true);
          verify(
            storageService.updateToken(resultMap['data']['token'] as String),
          );
        },
      );
    },
  );
  group('logout', () {
    test(
      'should remove token from hot storage and local storage upon logout',
      () async {
        await authenticationService.logout();

        verify(hotStorageService.updateToken(''));
        verify(storageService.updateToken(''));
      },
    );
  });
}
