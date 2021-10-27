import 'package:flutter/material.dart';

class EpisodePageAppBar extends StatelessWidget with PreferredSizeWidget {
  const EpisodePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
