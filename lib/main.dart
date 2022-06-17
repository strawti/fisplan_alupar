import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app_widget.dart';
import 'app/core/app_notifications.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // TODO: Precisa configurar o firebase ou o sentry
    //await Firebase.initializeApp();
    //await AppNotifications().init();
    await GetStorage.init();

    //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const AppWidget());
  }, (Object error, StackTrace stack) {
 //   FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
