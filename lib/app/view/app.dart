import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/views/login/login_page.dart';
import 'package:tv_shows/ui/views/shows/shows_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _loginViewModel = serviceLocator<LoginViewModel>();

  @override
  void initState() {
    _loginViewModel.autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFFFF758C)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFFFF758C),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      home: getInitialScreen(),
    );
  }

  Widget getInitialScreen() {
    if (_loginViewModel.loginStatus == LoginStatus.authenticated) {
      return ShowsPage();
    }
    return const LoginPage();
  }
}
