import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/models/image_data.dart';
import 'package:tv_shows/business_logic/viewmodels/episode_viewmodel.dart';
import 'package:tv_shows/services/episodes/episodes_service.dart';

import 'episode_viewmodel_test.mocks.dart';

@GenerateMocks([EpisodeService])
void main() {
  late MockEpisodeService episodeService;
  late EpisodeViewModel viewModel;

  setUpAll(() {
    episodeService = MockEpisodeService();
    viewModel = EpisodeViewModel(episodeService: episodeService);
  });

  test(
    'should post episode with no error',
    () async {
      // arrange
      when(
        episodeService.uploadEpisode(
          description: anyNamed('description'),
          episodeNumber: anyNamed('episodeNumber'),
          mediaId: anyNamed('mediaId'),
          season: anyNamed('season'),
          showId: anyNamed('showId'),
          title: anyNamed('title'),
        ),
      ).thenAnswer((realInvocation) async {});
      // act
      await viewModel.postEpisode(
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
    'should return ImageData when calling uploadImage()',
    () async {
      final imageData = ImageData(
        imageUrl: '',
        mediaId: '',
      );
      // arrange
      when(episodeService.uploadImage()).thenAnswer(
        (realInvocation) async => imageData,
      );
      // act
      final result = await viewModel.uploadImage();
      // assert
      expect(result, isA<ImageData>());
    },
  );
}
