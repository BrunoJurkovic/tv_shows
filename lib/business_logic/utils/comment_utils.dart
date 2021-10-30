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

class PostCommentResponse {
  const PostCommentResponse({required this.token});

  final String token;
}

class PostCommentRequest extends BaseHttpPostRequest {
  const PostCommentRequest(this.text, this.episodeId)
      : super(endpoint: '/api/comments');

  final String text, episodeId;

  @override
  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'text': text,
      'episodeId': episodeId,
    } as Map<String, dynamic>;
  }
}
