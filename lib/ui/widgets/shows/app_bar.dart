import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowsAppBar extends StatelessWidget with PreferredSizeWidget {
  const ShowsAppBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: titleWidget(),
      actions: [
        logOutButton(),
      ],
    );
  }

  IconButton logOutButton() {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(
        Icons.logout,
        color: Colors.black,
      ),
    );
  }

  Text titleWidget() {
    return const Text(
      'Shows',
      style: TextStyle(
        fontSize: 32,
        color: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
