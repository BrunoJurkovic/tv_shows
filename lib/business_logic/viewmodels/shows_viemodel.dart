import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/services/shows/shows_service.dart';

class ShowsViewModel extends ChangeNotifier {
  ShowsViewModel({required this.showsService});

  final ShowsService showsService;

  Future<List<Show>> fetchShows() async {
    final response = await showsService.getShows();
    final output = <Show>[];
    for (final show in response) {
      output.add(show);
    }
    return output;
  }
}
