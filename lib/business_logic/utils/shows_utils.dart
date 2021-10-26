import 'package:tv_shows/services/http/http_service.dart';

class ShowsResponse {
  const ShowsResponse({required this.data});

  factory ShowsResponse.fromMap(Map<String, dynamic> map) {
    return ShowsResponse(
      // ignore: avoid_dynamic_calls
      data: map['data'] as List<dynamic>,
    );
  }

  final List<dynamic> data;
}

class ShowsRequest extends BaseHttpGetRequest {
  const ShowsRequest() : super(endpoint: '/api/shows');
}
