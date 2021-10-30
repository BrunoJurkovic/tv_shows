import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tv_shows/business_logic/viewmodels/episode_viewmodel.dart';
import 'package:tv_shows/ui/views/add_episode/add_episode_page.dart';

class AddEpisodeAppBar extends StatelessWidget with PreferredSizeWidget {
  const AddEpisodeAppBar({
    Key? key,
    required this.size,
    required this.onAdd,
    required this.onCancel,
    required this.mediaId,
    required this.episodeViewModel,
    required this.widget,
  }) : super(key: key);

  final Size size;
  final VoidCallback onAdd;
  final VoidCallback onCancel;
  final String? mediaId;
  final EpisodeViewModel episodeViewModel;
  final AddEpisodePage widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        onPressed: onCancel,
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onAdd,
          child: Text(
            'Add',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
