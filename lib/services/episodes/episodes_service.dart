import 'package:tv_shows/business_logic/models/episode.dart';
import 'package:tv_shows/business_logic/models/image_data.dart';

abstract class EpisodeService {
  Future<ImageData> uploadImage();
  Future<void> uploadEpisode(
      {required String showId,
      required String title,
      required String description,
      required String episodeNumber,
      required String season,
      required String mediaId});
}
