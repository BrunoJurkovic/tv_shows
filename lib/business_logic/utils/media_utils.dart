import 'package:dio/dio.dart';
import 'package:tv_shows/services/http/http_service.dart';

class MediaResponse {
  const MediaResponse({required this.mediaId});

  factory MediaResponse.fromMap(Map<String, dynamic> map) {
    return MediaResponse(
      // ignore: avoid_dynamic_calls
      mediaId: map['data']['_id'] as String,
    );
  }

  final String mediaId;
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
