import 'package:tv_shows/business_logic/models/comment.dart';
import 'package:tv_shows/business_logic/utils/comment_utils.dart';
import 'package:tv_shows/services/comment/comment_service.dart';
import 'package:tv_shows/services/http/http_service.dart';

class CommentServiceImpl implements CommentService {
  CommentServiceImpl({required this.httpService});

  final BaseHttpService httpService;

  @override
  Future<List<Comment>> getComments(String id) async {
    final response = await httpService.get(
      request: CommentRequest(id),
    ) as Map<String, dynamic>;
    final result = CommentResponse.fromMap(response);
    final output = <Comment>[];
    for (final show in result.data) {
      output.add(Comment.fromMap(show as Map<String, dynamic>));
    }
    return output;
  }
}
