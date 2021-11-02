import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/models/comment.dart';
import 'package:tv_shows/services/comment/comment_service.dart';
import 'package:tv_shows/services/comment/comment_service_impl.dart';

import '../auth/auth_impl_test.mocks.dart';

void main() {
  late MockBaseHttpService httpService;
  late CommentService commentService;

  setUpAll(() {
    httpService = MockBaseHttpService();
    commentService = CommentServiceImpl(httpService: httpService);
  });

  test(
    'should return a List<Comment> when calling getComments()',
    () async {
      // arrange
      when(
        httpService.get(
          request: anyNamed('request'),
        ),
      ).thenAnswer(
        (realInvocation) async => {
          'data': [
            {
              'episodeId': '',
              'text': '',
              'userEmail': '',
              '_id': '',
            },
          ]
        },
      );
      // act
      final result = await commentService.getComments('');
      // assert
      expect(result, isA<List<Comment>>());
    },
  );
  test(
    'should upload comment with no error',
    () async {
      // arrange
      when(httpService.post(request: anyNamed('request')))
          .thenAnswer((realInvocation) async {});
      // act
      await commentService.postComment(text: '', id: '');
    },
  );
}
