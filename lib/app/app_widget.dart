import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app_bindings.dart';
import 'core/app_constants.dart';
import 'core/app_theme.dart';
import 'presenter/splash/splash_page.dart';
import 'routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: constAppTitle,
      debugShowCheckedModeBanner: false,
      theme: appThemeLight,
      darkTheme: appThemeDark,
      getPages: appPages,
      themeMode: ThemeMode.light,
      initialBinding: AppBindings(),
      initialRoute: SplashPage.route,
      fallbackLocale: const Locale('pt', 'BR'),
      defaultTransition: Transition.native,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      // builder: _builder,
    );
  }

  // TODO: COLOCAR QUANDO FOR SUBIR A APLICAÇÃO
  // Widget _builder(context, widget) {
  //   Widget error = const Text('...ERRO DE RENDERIZAÇÃO...');

  //   if (widget is Scaffold || widget is Navigator) {
  //     error = Scaffold(body: Center(child: error));
  //   }

  //   ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;

  //   return widget;
  // }
}
