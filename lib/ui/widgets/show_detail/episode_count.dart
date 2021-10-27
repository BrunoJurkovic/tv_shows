import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';

class EpisodeCountText extends StatelessWidget {
  const EpisodeCountText({
    Key? key,
    required this.size,
    required this.showDetails,
  }) : super(key: key);

  final Size size;
  final ShowDetails showDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Episodes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(
          '${showDetails.episodes.length}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
