import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';

abstract class ShowsService {
  Future<List<Show>> getShows();
  Future<ShowDetails> getShowDetails(String id);
}
