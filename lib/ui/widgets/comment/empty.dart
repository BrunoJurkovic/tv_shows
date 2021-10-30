import 'package:flutter/material.dart';

class EmptyComments extends StatelessWidget {
  const EmptyComments({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: size.height * 0.15,
              height: size.height * 0.15,
              child: Image.asset(
                'assets/images/empty.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: size.height * 0.3,
              height: size.height * 0.15,
              child: const Text(
                'Sorry, we don’t have comments yet. Be first who will write a review.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
