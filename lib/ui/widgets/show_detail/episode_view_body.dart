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
        EpisodeImage(
          width: size.width,
          height: size.height * 0.4,
          imagePath: showDetails.imagePath,
        ),
        EpisodeTitle(text: showDetails.title),
        EpisodeDescription(text: showDetails.description),
        episodeCount(),
        listView(),
      ],
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

class EpisodeDescription extends StatelessWidget {
  const EpisodeDescription({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}

class EpisodeTitle extends StatelessWidget {
  const EpisodeTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class EpisodeImage extends StatelessWidget {
  const EpisodeImage({
    Key? key,
    required this.height,
    required this.width,
    required this.imagePath,
  }) : super(key: key);

  final double height;
  final double width;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
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
          imageUrl: imagePath != ''
              ? 'https://api.infinum.academy/$imagePath'
              : 'https://via.placeholder.com/600',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
