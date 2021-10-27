import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/episode.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_detail.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_number.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_title.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    Key? key,
    required this.size,
    required this.episode,
  }) : super(key: key);

  final Size size;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EpisodeNumberText(size: size, episode: episode),
          EpisodeTitleText(size: size, episode: episode),
          EpisodeDetailButton(onPressed: () {}),
        ],
      ),
    );
  }
}
