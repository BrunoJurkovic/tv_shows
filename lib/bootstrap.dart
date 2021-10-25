import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:tv_shows/services/service_locator.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  await runZonedGuarded(
    () async {
      runApp(
        await builder(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
