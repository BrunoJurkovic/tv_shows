// ignore_for_file: avoid_dynamic_calls

import 'package:tv_shows/services/http/http_service.dart';

class ShowsResponse {
  const ShowsResponse({required this.data});

  factory ShowsResponse.fromMap(Map<String, dynamic> map) {
    return ShowsResponse(
      data: map['data'] as List<dynamic>,
    );
  }

  final List<dynamic> data;
}

class ShowsRequest extends BaseHttpGetRequest {
  const ShowsRequest() : super(endpoint: '/api/shows');
}

class ShowDetailsResponse {
  const ShowDetailsResponse({
    required this.title,
    required this.description,
    required this.id,
    required this.likeCount,
    required this.imagePath,
  });

  factory ShowDetailsResponse.fromMap(Map<String, dynamic> map) {
    return ShowDetailsResponse(
      description: map['data']['description'] as String,
      id: map['data']['_id'] as String,
      imagePath: map['data']['imageUrl'] as String,
      likeCount: map['data']['likesCount'] as int,
      title: map['data']['title'] as String,
    );
  }

  final String title;
  final String description;
  final String id;
  final int likeCount;
  final String imagePath;
}

class ShowDetailsRequest extends BaseHttpGetRequest {
  const ShowDetailsRequest(this.id) : super(endpoint: '/api/shows/$id');
  final String id;
}
