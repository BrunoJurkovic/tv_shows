import 'package:tv_shows/services/http/http_service.dart';

class AllEpisodesResponse {
  const AllEpisodesResponse({required this.data});

  factory AllEpisodesResponse.fromMap(Map<String, dynamic> map) {
    return AllEpisodesResponse(
      data: map['data'] as List<dynamic>,
    );
  }

  final List<dynamic> data;
}

class AllEpisodesRequest extends BaseHttpGetRequest {
  const AllEpisodesRequest(this.showId)
      : super(endpoint: '/api/shows/$showId/episodes');
  final String showId;
}
