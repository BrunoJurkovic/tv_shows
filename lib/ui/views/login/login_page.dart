import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final _loginViewModel = serviceLocator<LoginViewModel>();

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
                  onPressed: () async {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      final val = _formKey.currentState!.value;
                      debugPrint(_formKey.currentState!.value.toString());
                      await _loginViewModel.login(
                          val['email'] as String, val['password'] as String);
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
