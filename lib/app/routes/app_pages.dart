import 'package:fisplan_alupar/app/presenter/home/home_bindings.dart';
import 'package:fisplan_alupar/app/presenter/home/home_page.dart';
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
  GetPage(
    name: HomePage.route,
    page: () => const HomePage(),
    binding: HomeBindings(),
  ),
];
