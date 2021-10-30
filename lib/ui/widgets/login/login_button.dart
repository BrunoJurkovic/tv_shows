import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle(context),
      child: buttonText(),
    );
  }

  Text buttonText() {
    return const Text(
      'LOG IN',
      style: TextStyle(fontSize: 18),
    );
  }

  ButtonStyle buttonStyle(BuildContext context) {
    return ButtonStyle(
      alignment: Alignment.center,
      backgroundColor: MaterialStateProperty.all<Color>(
        Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
