import 'package:tv_shows/business_logic/models/comment.dart';

abstract class CommentService {
  Future<List<Comment>> getComments(String id);
  Future<void> postComment({required String text, required String id});
}
