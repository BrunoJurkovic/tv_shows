import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/views/shows/shows_page.dart';
import 'package:tv_shows/ui/widgets/login/email_field.dart';
import 'package:tv_shows/ui/widgets/login/login_button.dart';
import 'package:tv_shows/ui/widgets/login/password_field.dart';
import 'package:tv_shows/ui/widgets/login/remember_checkbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _loginViewModel = serviceLocator<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FormBuilder(
        autovalidateMode: AutovalidateMode.disabled,
        key: _formKey,
        child: Column(
          children: [
            LogoImage(size: size),
            SizedBox(height: size.height * 0.05),
            SizedBox(
              width: size.width * 0.9,
              child: Column(
                children: [
                  const EmailField(),
                  SizedBox(height: size.height * 0.025),
                  const PasswordField(),
                  SizedBox(height: size.height * 0.025),
                  const RememberUserCheckbox(),
                  SizedBox(height: size.height * 0.025),
                  SizedBox(
                    width: size.width * 0.9,
                    height: size.height * 0.06,
                    child: LoginButton(
                      onPressed: _login,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      final val = _formKey.currentState!.value;
      debugPrint(_formKey.currentState!.value.toString());
      try {
        await _loginViewModel.login(
          val['email'] as String,
          val['password'] as String,
          rememberLogin: val['remember'] as bool,
        );
        // ignore: use_build_context_synchronously
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<LoginPage>(
            builder: (_) {
              return const ShowsPage();
            },
          ),
        );
      } catch (e) {
        MessageDialog(
          title: 'An error has occured',
          message: 'Please check your login info and your connection.',
          buttonOkColor: Theme.of(context).colorScheme.secondary,
        ).show(context);
      }
    } else {
      debugPrint('error');
    }
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.2),
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
