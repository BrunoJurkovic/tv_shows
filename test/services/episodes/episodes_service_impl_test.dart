import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/models/image_data.dart';
import 'package:tv_shows/services/episodes/episodes_service_impl.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/image_picker/image_picker.dart';

import 'episodes_service_impl_test.mocks.dart';

@GenerateMocks([ImagePickerService, BaseHttpService])
void main() {
  late MockImagePickerService imagePickerService;
  late MockBaseHttpService httpService;
  late EpisodeServiceImpl episodeService;

  setUpAll(() {
    imagePickerService = MockImagePickerService();
    httpService = MockBaseHttpService();
    episodeService = EpisodeServiceImpl(
      httpService: httpService,
      imagePickerService: imagePickerService,
    );
  });

  test(
    'should upload episode with no error',
    () async {
      // arrange
      when(
        httpService.post(
          request: anyNamed('request'),
        ),
      ).thenAnswer(
        (realInvocation) async {},
      );
      // act
      await episodeService.uploadEpisode(
        showId: '',
        title: '',
        description: '',
        episodeNumber: '',
        season: '',
        mediaId: '',
      );
    },
  );
  test(
    'should upload image and return ImageData',
    () async {
      // arrange
      when(imagePickerService.getFormDataFromImage()).thenAnswer(
        (realInvocation) async => FormData.fromMap(
          <String, String>{'': ''},
        ),
      );
      when(
        httpService.postFormData(
          request: anyNamed('request'),
        ),
      ).thenAnswer(
        (realInvocation) async => {
          'data': {'_id': 'id', 'path': 'path'}
        },
      );
      // act
      final result = await episodeService.uploadImage();
      // assert
      expect(result, isA<ImageData>());
    },
  );
}
