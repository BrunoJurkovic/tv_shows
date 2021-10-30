import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
