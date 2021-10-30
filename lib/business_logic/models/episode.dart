class Episode {
  Episode({
    required this.episodeId,
    required this.title,
    required this.description,
    required this.episodeNumber,
    required this.season,
    required this.imageUrl,
  });

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      episodeId: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      episodeNumber: map['episodeNumber'] as String,
      season: map['season'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  final String episodeId;
  final String title;
  final String description;
  final String episodeNumber;
  final String season;
  final String imageUrl;
}
