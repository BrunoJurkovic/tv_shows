import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tv_shows/ui/views/login/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
      home: LoginPage(),
    );
  }
}
