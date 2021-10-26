import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/services/shows/shows_service.dart';

class ShowsViewModel extends ChangeNotifier {
  ShowsViewModel({required this.showsService});

  final ShowsService showsService;
  final List<Show> _shows = [];

  List<Show> get shows => _shows;

  Future<void> fetchShows() async {
    final response = await showsService.getShows();
    for (final show in response) {
      _shows.add(show);
    }
    notifyListeners();
  }
}
