import 'package:fisplan_alupar/app/presenter/splash/splash_page.dart';
import 'package:get/get.dart';

import 'routes_imports.dart';

final List<GetPage> appPages = [
  GetPage(
    name: SplashPage.route,
    page: () => const SplashPage(),
  ),
  GetPage(
    name: LoginPage.route,
    page: () => const LoginPage(),
    binding: LoginBindings(),
  ),
];
