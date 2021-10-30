import 'package:flutter/material.dart';

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
