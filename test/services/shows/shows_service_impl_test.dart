import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/business_logic/utils/episode_utils.dart';
import 'package:tv_shows/business_logic/utils/shows_utils.dart';
import 'package:tv_shows/services/shows/shows_service.dart';
import 'package:tv_shows/services/shows/shows_service_impl.dart';

import '../auth/auth_impl_test.mocks.dart';
import 'shows_service_impl_test.mocks.dart';

@GenerateMocks([ShowDetailsRequest, AllEpisodesRequest])
void main() {
  late MockBaseHttpService httpService;
  late ShowsService showsService;

  setUpAll(() {
    httpService = MockBaseHttpService();
    showsService = ShowsServiceImpl(httpService: httpService);
  });

  test(
    'should return a List<Show> when getShows() is called',
    () async {
      // arrange
      when(
        httpService.get(request: anyNamed('request')),
      ).thenAnswer(
        (realInvocation) async => <String, dynamic>{
          'data': [
            {
              '_id': 'fdsofasf',
              'title': 'Test show',
              'imageUrl': 'https://test.com',
              'likesCount': 44,
            }
          ],
        },
      );
      // act
      final result = await showsService.getShows();
      // assert
      expect(result, isA<List<Show>>());
    },
  );
  test(
    'should return ShowDetails when calling getShowDetails()',
    () async {
      // arrange

      when(
        httpService.get(
          request: argThat(isA<ShowDetailsRequest>(), named: 'request'),
        ),
      ).thenAnswer(
        (realInvocation) async => <String, dynamic>{
          'data': {
            '_id': 'fdsofasf',
            'title': 'Test show',
            'imageUrl': 'https://test.com',
            'likesCount': 44,
            'description': '',
          },
        },
      );
      when(
        httpService.get(
          request: argThat(isA<AllEpisodesRequest>(), named: 'request'),
        ),
      ).thenAnswer(
        (realInvocation) async => <String, dynamic>{
          'data': [
            {
              '_id': 'fdsofasf',
              'title': 'Test show',
              'imageUrl': 'https://test.com',
              'description': '',
              'episodeNumber': '0',
              'season': '0'
            },
            {
              '_id': 'fdsofasf',
              'title': 'Test show',
              'imageUrl': 'https://test.com',
              'description': '',
              'episodeNumber': '0',
              'season': '0',
            },
          ],
        },
      );
      // act
      final result = await showsService.getShowDetails('fdsofasf');
      // assert
      expect(result, isA<ShowDetails>());
    },
  );
}
