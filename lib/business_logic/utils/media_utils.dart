// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:tv_shows/services/http/http_service.dart';

class MediaResponse {
  const MediaResponse({required this.mediaId, required this.imagePath});

  factory MediaResponse.fromMap(Map<String, dynamic> map) {
    return MediaResponse(
      mediaId: map['data']['_id'] as String,
      imagePath: map['data']['path'] as String,
    );
  }

  final String mediaId;
  final String imagePath;
}

class MediaRequest extends BaseHttpPostRequest {
  const MediaRequest(this.formData) : super(endpoint: '/api/media');

  final FormData formData;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': formData,
    };
  }
}
