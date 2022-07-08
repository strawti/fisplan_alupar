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
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: NewInspectionPage.route,
    page: () => const NewInspectionPage(),
    binding: NewInspectionBindings(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: InspectionsPage.route,
    page: () => const InspectionsPage(),
    binding: InspectionsBindings(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: DownloadDataPage.route,
    page: () => const DownloadDataPage(),
    binding: DownloadDataBindings(),
  ),
  GetPage(
    name: DetailsInspectionPage.route,
    page: () => const DetailsInspectionPage(),
    binding: DetailsInspectionBindings(),
  ),
];
