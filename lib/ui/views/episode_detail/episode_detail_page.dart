import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/episode.dart';
import 'package:tv_shows/ui/views/comment/comment_page.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_app_bar.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_view_body.dart';

class EpisodeDetailPage extends StatelessWidget {
  const EpisodeDetailPage({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const EpisodePageAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EpisodeImage(
            height: size.height * 0.5,
            width: size.width,
            imagePath: episode.imageUrl,
          ),
          EpisodeTitle(text: episode.title),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25,
            ),
            child: Text(
              'S${episode.season} Ep${episode.episodeNumber}',
              style: const TextStyle(
                color: Color(0xFFFF758C),
                fontSize: 16,
              ),
            ),
          ),
          Expanded(child: EpisodeDescription(text: episode.description)),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: size.width * 0.4,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<CommentPage>(
                        builder: (ctx) => CommentPage(
                          episodeId: episode.episodeId,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.comment,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Comment',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
