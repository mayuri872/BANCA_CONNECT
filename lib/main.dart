import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'environment/environment.dart';
import 'init_app.dart';

void main() async {
  bootstrap(() {
    // return const InitApp();
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const InitApp();
      },
    );
  });
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    // log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.STAGING,
  );

  Environment().initConfig(environment);
  // if (AppConfig.FIREBASE_ENABLE) {
  //   await Firebase.initializeApp();
  //   if (Environment().config?.env == Environment.STAGING) {
  //     FirebaseMessaging.instance.subscribeToTopic('QA');
  //   } else {
  //     FirebaseMessaging.instance.subscribeToTopic('ALL');
  //   }
  // }

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
