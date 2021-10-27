import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'email',
      autocorrect: false,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email(context),
        FormBuilderValidators.required(context),
      ]),
      decoration: emailDecoration(),
    );
  }

  InputDecoration emailDecoration() {
    return const InputDecoration(
      hintText: 'Email',
      labelText: 'Email',
      focusColor: Color(0xFFFF758C),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 0.1,
        ),
      ),
    );
  }
}
