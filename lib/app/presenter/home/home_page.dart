import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './home_controller.dart';
import '../new_inspection/new_inspection_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos'),
        leading: IconButton(
          icon: const Text('Sair'),
          onPressed: () async {
            // TODO: DIALOG PARA CONFIRMAR SAIDA
            // PARA TESTE

            Get.toNamed(NewInspectionPage.route);
          },
        ),
      ),
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Atualizar dados'),
      ),
    );
  }
}
