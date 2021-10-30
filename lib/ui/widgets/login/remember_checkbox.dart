import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RememberUserCheckbox extends StatelessWidget {
  const RememberUserCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: 'remember',
      activeColor: Theme.of(context).colorScheme.secondary,
      title: const Text('Remember me'),
      initialValue: false,
    );
  }
}
