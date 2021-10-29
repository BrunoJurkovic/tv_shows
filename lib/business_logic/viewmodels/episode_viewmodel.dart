import 'package:flutter/material.dart';
import 'package:tv_shows/services/episodes/episodes_service.dart';

class EpisodeViewModel extends ChangeNotifier {
  EpisodeViewModel({required this.episodeService});

  final EpisodeService episodeService;

  Future<void> pickAndUploadImage({
    required String showId,
    required String title,
    required String description,
    required String episodeNumber,
    required String season,
    required String mediaId,
  }) async {
    try {
      await episodeService.uploadEpisode(
        showId: showId,
        title: title,
        description: description,
        episodeNumber: episodeNumber,
        season: season,
        mediaId: mediaId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImage() async {
    try {
      final response = await episodeService.uploadImage();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
