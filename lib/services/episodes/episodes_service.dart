import 'package:tv_shows/business_logic/models/episode.dart';

abstract class EpisodeService {
  Future<Episode> getEpisodeById(String id);
  Future<void> uploadEpisode({
    required String showId,
    required String title,
    required String description,
    required String episodeNumber,
    required String season,
  });
}
