import 'package:get/get.dart';

import 'routes_imports.dart';

final List<GetPage> appPages = [
  GetPage(
    name: LoginPage.route,
    page: () => const LoginPage(),
    binding: LoginBindings(),
  ),
];
