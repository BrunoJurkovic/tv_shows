import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FormBuilder(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'email',
                  autocorrect: false,
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                ),
                MaterialButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      debugPrint(_formKey.currentState!.value.toString());
                    } else {
                      debugPrint('error');
                    }
                  },
                  child: const Text('LOGIN BUTTON'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
