import 'package:tv_shows/business_logic/models/show.dart';

abstract class ShowsService {
  Future<List<Show>> getShows();
}
