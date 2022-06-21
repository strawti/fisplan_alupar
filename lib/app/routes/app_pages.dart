import 'package:fisplan_alupar/app/presenter/home/home_bindings.dart';
import 'package:fisplan_alupar/app/presenter/home/home_page.dart';
import 'package:fisplan_alupar/app/presenter/inspections/inspections_page.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/new_inspection_bindings.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/new_inspection_page.dart';
import 'package:fisplan_alupar/app/presenter/selection_page/selection_page.dart';
import 'package:fisplan_alupar/app/presenter/splash/splash_page.dart';
import 'package:get/get.dart';

import '../presenter/inspections/inspections_bindings.dart';
import '../presenter/selection_page/selection_bindings.dart';
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
