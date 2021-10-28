import 'package:tv_shows/services/http/http_service.dart';

class CommentResponse {
  const CommentResponse({required this.data});

  factory CommentResponse.fromMap(Map<String, dynamic> map) {
    return CommentResponse(
      data: map['data'] as List<dynamic>,
    );
  }

  final List<dynamic> data;
}

class CommentRequest extends BaseHttpGetRequest {
  const CommentRequest(this.id) : super(endpoint: '/api/episodes/$id/comments');
  final String id;
}
