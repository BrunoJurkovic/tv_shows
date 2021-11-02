import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/services/hot_storage/hot_storage.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/http/http_service_impl.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

import 'http_service_impl_test.mocks.dart';

class FakeHttpGetRequest implements BaseHttpGetRequest {
  @override
  String get endpoint => '';
}

class FakeHttpPostRequest implements BaseHttpPostRequest {
  @override
  String get endpoint => '';

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'b': 'a'};
  }
}

@GenerateMocks([
  StorageService,
  HotStorageService,
  Dio,
])
void main() {
  late StorageService storageService;
  late HotStorageService hotStorageService;
  late Dio dio;
  late BaseHttpService httpService;
  late DioAdapter dioAdapter;

  setUpAll(() {
    storageService = MockStorageService();
    hotStorageService = MockHotStorageService();
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    httpService = DioHttpService(dio, storageService, hotStorageService);
  });

  test(
    'should return response data from get request',
    () async {
      // arrange
      when(storageService.getToken())
          .thenAnswer((realInvocation) => 'dsfafdsfa');
      dioAdapter.onGet(
        '',
        (server) => server.reply(200, ''),
      );
      // act
      final response = await httpService.get(
        request: FakeHttpGetRequest(),
      ) as String;
      // assert
      expect(
        response,
        '',
      );
    },
  );
}
