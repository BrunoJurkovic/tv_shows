import 'package:flutter/material.dart';

class EpisodeDetailButton extends StatelessWidget {
  const EpisodeDetailButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_right,
          ),
        ),
      ),
    );
  }
}
