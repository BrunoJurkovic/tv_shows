import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/business_logic/viewmodels/episode_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/widgets/add_episode/add_episode_app_bar.dart';
import 'package:tv_shows/ui/widgets/add_episode/detail_input.dart';
import 'package:tv_shows/ui/widgets/add_episode/image_button.dart';

class AddEpisodePage extends StatefulWidget {
  const AddEpisodePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<AddEpisodePage> createState() => _AddEpisodePageState();
}

class _AddEpisodePageState extends State<AddEpisodePage> {
  final _key = GlobalKey<FormBuilderState>();

  final episodeViewModel = serviceLocator<EpisodeViewModel>();

  String? mediaId;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AddEpisodeAppBar(
        size: size,
        onAdd: () {
          final state = _key.currentState!..save();
          if (mediaId == null) return;
          if (state.validate()) {
            final value = state.value;
            episodeViewModel.postEpisode(
              showId: widget.id,
              title: value['title'] as String,
              description: value['description'] as String,
              episodeNumber: value['episode'] as String,
              season: value['season'] as String,
              mediaId: mediaId!,
            );
          }
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
        mediaId: mediaId,
        episodeViewModel: episodeViewModel,
        widget: widget,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl == null)
            AddImageButton(
              notifyParent: () => setState(() {}),
              onTap: () async {
                final result = await episodeViewModel.uploadImage();
                mediaId = result.mediaId;
                imageUrl = result.imageUrl;
                setState(() {});
              },
            ),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: 'https://api.infinum.academy/$imageUrl',
                width: size.width * 0.5,
                height: size.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(
            height: size.height * 0.6,
            child: Center(
              child: FormBuilder(
                key: _key,
                child: Column(
                  children: const [
                    EpisodeDetailInput(id: 'title', title: 'Title'),
                    EpisodeDetailInput(id: 'episode', title: 'Episode'),
                    EpisodeDetailInput(id: 'season', title: 'Season'),
                    EpisodeDetailInput(id: 'description', title: 'Description'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
