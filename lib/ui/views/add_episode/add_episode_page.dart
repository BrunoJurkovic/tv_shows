import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/business_logic/viewmodels/episode_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';

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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Add episode',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: size.width * 0.25,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
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
              setState(() {});
            },
            child: Text(
              'Add',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
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

class EpisodeDetailInput extends StatelessWidget {
  const EpisodeDetailInput({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FormBuilderTextField(
        name: id,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
        decoration: InputDecoration(
          label: Text(title),
          hintText: title,
        ),
      ),
    );
  }
}

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    Key? key,
    required this.onTap,
    required this.notifyParent,
  }) : super(key: key);

  final VoidCallback onTap;
  final Function() notifyParent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () {
          onTap();
          notifyParent();
        },
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.secondary,
                size: 36,
              ),
              Text(
                'Upload photo',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
