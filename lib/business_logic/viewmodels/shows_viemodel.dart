import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/services/shows/shows_service.dart';

class ShowsViewModel extends ChangeNotifier {
  ShowsViewModel({required this.showsService});

  final ShowsService showsService;

  Future<List<Show>> fetchShows() async {
    final response = await showsService.getShows();
    return response;
  }

  Future<ShowDetails> fetchShowDetails(String id) async {
    final response = await showsService.getShowDetails(id);
    return response;
  }
}
