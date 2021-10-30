import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/episode.dart';

class EpisodeTitleText extends StatelessWidget {
  const EpisodeTitleText({
    Key? key,
    required this.size,
    required this.episode,
  }) : super(key: key);

  final Size size;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        child: SizedBox(
          width: size.width * 0.2,
          child: Text(
            episode.title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
