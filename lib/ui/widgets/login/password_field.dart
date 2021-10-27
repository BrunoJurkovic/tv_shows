import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: !isVisible,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 5),
        FormBuilderValidators.required(context),
      ]),
      decoration: passwordInputDecoration(),
    );
  }

  InputDecoration passwordInputDecoration() {
    return InputDecoration(
      hintText: 'Password',
      labelText: 'Password',
      focusColor: const Color(0xFFFF758C),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 0.1,
        ),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        icon: Icon(
          isVisible ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
          color: const Color(0xFFFF758C),
        ),
      ),
    );
  }
}
