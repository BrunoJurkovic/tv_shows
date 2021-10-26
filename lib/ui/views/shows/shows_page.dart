import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/views/login/login_page.dart';
import 'package:tv_shows/ui/widgets/shows/app_bar.dart';

class ShowsPage extends StatelessWidget {
  ShowsPage({Key? key}) : super(key: key);

  final _loginViewModel = serviceLocator<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowsAppBar(
        onTap: () async {
          await _loginViewModel.logout();
          // ignore: use_build_context_synchronously
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute<LoginPage>(
              builder: (_) {
                return const LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
