import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEpisodePage extends StatelessWidget {
  const AddEpisodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text('Add Episode'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
