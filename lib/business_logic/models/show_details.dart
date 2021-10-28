import 'package:tv_shows/business_logic/models/episode.dart';

enum ShowType { show }

class ShowDetails {
  ShowDetails({
    required this.title,
    required this.description,
    required this.id,
    required this.likeCount,
    required this.imagePath,
    required this.episodes,
  });

  final String title;
  final String description;
  final String id;
  final int likeCount;
  final String imagePath;
  final List<Episode> episodes;
}
