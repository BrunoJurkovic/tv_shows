import 'package:tv_shows/business_logic/models/episode.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/business_logic/utils/episode_utils.dart';
import 'package:tv_shows/business_logic/utils/shows_utils.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/shows/shows_service.dart';

class ShowsServiceImpl implements ShowsService {
  ShowsServiceImpl({
    required this.httpService,
  });

  BaseHttpService httpService;

  @override
  Future<List<Show>> getShows() async {
    final response = await httpService.get(
      request: const ShowsRequest(),
    ) as Map<String, dynamic>;
    final result = ShowsResponse.fromMap(response);
    final output = <Show>[];
    for (final show in result.data) {
      output.add(Show.fromMap(show as Map<String, dynamic>));
    }
    return output;
  }

  @override
  Future<ShowDetails> getShowDetails(String id) async {
    final response = await httpService.get(
      request: ShowDetailsRequest(id),
    ) as Map<String, dynamic>;
    final result = ShowDetailsResponse.fromMap(response);
    final episodes = await _getShowEpisodes(id);
    final output = ShowDetails(
      title: result.title,
      description: result.description,
      id: id,
      likeCount: result.likeCount,
      imagePath: result.imagePath,
      episodes: episodes,
    );
    return output;
  }

  Future<List<Episode>> _getShowEpisodes(String showId) async {
    final response = await httpService.get(
      request: AllEpisodesRequest(showId),
    ) as Map<String, dynamic>;
    final result = AllEpisodesResponse.fromMap(response);
    final output = <Episode>[];
    for (final episode in result.data) {
      output.add(Episode.fromMap(episode as Map<String, dynamic>));
    }
    return output;
  }
}
