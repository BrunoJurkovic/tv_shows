import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/episode.dart';

class EpisodeNumberText extends StatelessWidget {
  const EpisodeNumberText({
    Key? key,
    required this.size,
    required this.episode,
  }) : super(key: key);

  final Size size;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: size.width * 0.2,
        child: Text(
          'S${episode.season} Ep${episode.episodeNumber}',
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFFFF758C),
          ),
        ),
      ),
    );
  }
}
