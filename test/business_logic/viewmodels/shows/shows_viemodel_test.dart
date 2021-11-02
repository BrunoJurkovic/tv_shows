import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/business_logic/viewmodels/shows_viemodel.dart';
import 'package:tv_shows/services/shows/shows_service.dart';

import 'shows_viemodel_test.mocks.dart';

@GenerateMocks([ShowsService])
void main() {
  late MockShowsService showsService;
  late ShowsViewModel viewModel;

  setUpAll(() {
    showsService = MockShowsService();
    viewModel = ShowsViewModel(showsService: showsService);
  });

  test(
    'should return List<Show> when fetching shows',
    () async {
      // arrange
      when(showsService.getShows()).thenAnswer(
        (realInvocation) async => <Show>[],
      );
      // act
      final result = await viewModel.fetchShows();
      // assert
      expect(result, isA<List<Show>>());
    },
  );
  test(
    'should return ShowDetails when fetching specific shows',
    () async {
      // arrange
      when(showsService.getShowDetails(any)).thenAnswer(
        (realInvocation) async => ShowDetails(
          title: '',
          description: '',
          id: '',
          likeCount: 0,
          imagePath: '',
          episodes: [],
        ),
      );

      // act
      final result = await viewModel.fetchShowDetails('');
      // assert
      expect(result, isA<ShowDetails>());
    },
  );
}
