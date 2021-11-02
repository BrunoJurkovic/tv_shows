import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/services/storage/storage_service.dart';
import 'package:tv_shows/services/storage/storage_service_impl.dart';

import 'storage_service_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late StorageService storageService;
  late SharedPreferences sharedPreferences;

  setUpAll(() {
    sharedPreferences = MockSharedPreferences();
    storageService = StorageServiceImpl(sharedPreferences);
  });

  test(
    'should return token when getToken() is called',
    () async {
      // arrange
      when(sharedPreferences.get(TOKEN_STRING)).thenReturn('tokentokentoken');
      // act
      final token = storageService.getToken();
      // assert
      expect(token, 'tokentokentoken');
    },
  );
  test(
    'should return empty string if token is null',
    () async {
      // arrange
      when(sharedPreferences.get(TOKEN_STRING)).thenReturn(null);
      // act
      final token = storageService.getToken();
      // assert
      expect(token, '');
    },
  );
  test(
    'should update token when updateToken() is called',
    () async {
      // arrange
      when(sharedPreferences.setString(TOKEN_STRING, 'token'))
          .thenAnswer((realInvocation) async => true);
      // act
      await storageService.updateToken('token');
      // assert
      verify(sharedPreferences.setString(TOKEN_STRING, 'token'));
    },
  );
}
