import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/business_logic/models/comment.dart';
import 'package:tv_shows/business_logic/viewmodels/comment_viewmodel.dart';
import 'package:tv_shows/services/comment/comment_service.dart';

import 'comment_viewmodel_test.mocks.dart';

@GenerateMocks([CommentService])
void main() {
  late MockCommentService commentService;
  late CommentViewModel viewModel;

  setUpAll(() {
    commentService = MockCommentService();
    viewModel = CommentViewModel(commentService: commentService);
  });

  test(
    'should return a List<Comment> when calling fetchComments()',
    () async {
      // arrange
      when(commentService.getComments(any)).thenAnswer(
        (realInvocation) async => <Comment>[],
      );
      // act
      final result = await viewModel.fetchComments('');
      // assert
      expect(result, isA<List<Comment>>());
    },
  );
  group('postComment', () {
    test(
      'should post comment and return true',
      () async {
        // arrange
        when(commentService.getComments(any)).thenAnswer(
          (realInvocation) async => <Comment>[],
        );
        when(
          commentService.postComment(
            id: anyNamed('id'),
            text: anyNamed('text'),
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        // act
        final result = await viewModel.postComment('', '');
        // assert
        expect(result, true);
      },
    );
    test(
      'should return false if an exception occurs.',
      () async {
        // arrange
        when(commentService.getComments(any)).thenAnswer(
          (realInvocation) async => <Comment>[],
        );
        when(
          commentService.postComment(
            id: anyNamed('id'),
            text: anyNamed('text'),
          ),
        ).thenThrow(Exception());
        // act
        final result = await viewModel.postComment('', '');
        // assert
        expect(result, false);
      },
    );
  });
}
