import 'package:fisplan_alupar/app/core/app_assets.dart';
import 'package:fisplan_alupar/app/core/app_token.dart';
import 'package:fisplan_alupar/app/presenter/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (AppToken.instance.hasToken()) {
        Get.offAllNamed(HomePage.route);
      } else {
        Get.offAllNamed(LoginPage.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Center(child: Image.asset(appAssetSplash)),
    );
  }
}
