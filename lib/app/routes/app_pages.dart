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
  GetPage(
    name: SelectionPage.route,
    page: () => const SelectionPage(),
    binding: SelectionBindings(),
  ),
  GetPage(
    name: NewInspectionPage.route,
    page: () => const NewInspectionPage(),
    binding: NewInspectionBindings(),
  ),
  GetPage(
    name: InspectionsPage.route,
    page: () => const InspectionsPage(),
    binding: InspectionsBindings(),
    transition: Transition.rightToLeft,
  ),
];
