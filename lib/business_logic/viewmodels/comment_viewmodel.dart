import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/comment.dart';
import 'package:tv_shows/services/comment/comment_service.dart';

class CommentViewModel extends ChangeNotifier {
  CommentViewModel({required this.commentService});

  final CommentService commentService;

  Future<List<Comment>> fetchComments(String id) async {
    final response = await commentService.getComments(id);
    return response;
  }
}
