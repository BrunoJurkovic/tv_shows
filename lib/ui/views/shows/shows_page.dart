import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/business_logic/viewmodels/shows_viemodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/views/login/login_page.dart';
import 'package:tv_shows/ui/widgets/shows/app_bar.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  final _loginViewModel = serviceLocator<LoginViewModel>();
  final _showsViewModel = serviceLocator<ShowsViewModel>();

  @override
  void initState() {
    Future.delayed(Duration.zero, _showsViewModel.fetchShows);
    super.initState();
  }

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
      body: ListView.builder(itemBuilder: (ctx, i) {
        return Container();
      }),
    );
  }
}
