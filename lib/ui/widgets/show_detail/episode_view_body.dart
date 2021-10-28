import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_count.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_list_item.dart';

class EpisodeViewBody extends StatelessWidget {
  const EpisodeViewBody({
    Key? key,
    required this.size,
    required this.showDetails,
  }) : super(key: key);

  final Size size;
  final ShowDetails showDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        episodeImage(),
        episodeTitle(),
        episodeDescription(),
        episodeCount(),
        listView(),
      ],
    );
  }

  SizedBox episodeImage() {
    return SizedBox(
      width: size.width,
      height: size.height * 0.4,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: CachedNetworkImage(
          imageUrl: 'https://api.infinum.academy/${showDetails.imagePath}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Padding episodeTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        showDetails.title,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Padding episodeDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ),
      child: Text(
        showDetails.description,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Padding episodeCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ),
      child: EpisodeCountText(size: size, showDetails: showDetails),
    );
  }

  Expanded listView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: showDetails.episodes.length,
          itemBuilder: (ctx, i) {
            final episode = showDetails.episodes[i];
            return EpisodeListItem(size: size, episode: episode);
          },
        ),
      ),
    );
  }
}
