// ignore_for_file: avoid_dynamic_calls

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

class EpisodeResponse {
  const EpisodeResponse({
    required this.episodeId,
    required this.title,
    required this.description,
    required this.episodeNumber,
    required this.season,
    required this.imageUrl,
  });

  factory EpisodeResponse.fromMap(Map<String, dynamic> map) {
    return EpisodeResponse(
      description: map['data']['description'] as String,
      episodeId: map['data']['_id'] as String,
      episodeNumber: map['data']['episodeNumber'] as String,
      imageUrl: map['data']['imageUrl'] as String,
      season: map['data']['season'] as String,
      title: map['data']['title'] as String,
    );
  }

  final String episodeId;
  final String title;
  final String description;
  final String episodeNumber;
  final String season;
  final String imageUrl;
}

class EpisodeRequest extends BaseHttpGetRequest {
  const EpisodeRequest(this.episodeId)
      : super(endpoint: '/api/shows/episodes/$episodeId');
  final String episodeId;
}
