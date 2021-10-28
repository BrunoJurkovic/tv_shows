import 'package:tv_shows/business_logic/models/episode.dart';
import 'package:tv_shows/business_logic/utils/episode_utils.dart';
import 'package:tv_shows/services/episodes/episodes_service.dart';
import 'package:tv_shows/services/http/http_service.dart';

class EpisodeServiceImpl implements EpisodeService {
  EpisodeServiceImpl({required this.httpService});

  final BaseHttpService httpService;

  @override
  Future<Episode> getEpisodeById(String id) async {
    final response = await httpService.get(
      request: EpisodeRequest(id),
    ) as Map<String, dynamic>;
    final result = EpisodeResponse.fromMap(response);
    return Episode(
      episodeId: result.episodeId,
      title: result.title,
      description: result.description,
      episodeNumber: result.episodeNumber,
      season: result.season,
      imageUrl: result.imageUrl,
    );
  }
}
