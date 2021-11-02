import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/services/hot_storage/hot_storage.dart';
import 'package:tv_shows/services/hot_storage/hot_storage_impl.dart';

void main() {
  late HotStorageService hotStorageService;

  setUpAll(() {
    hotStorageService = HotStorageServiceImpl();
  });

  test(
    'should return token when updated',
    () async {
      // arrange
      hotStorageService.updateToken('token');
      // act
      final result = hotStorageService.token;
      // assert
      expect(result, 'token');
    },
  );
}
