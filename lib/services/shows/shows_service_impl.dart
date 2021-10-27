import 'package:tv_shows/business_logic/models/show.dart';
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
}
