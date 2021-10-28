import 'package:tv_shows/business_logic/models/episode.dart';

abstract class EpisodeService {
  Future<Episode> getEpisodeById(String id);
}
