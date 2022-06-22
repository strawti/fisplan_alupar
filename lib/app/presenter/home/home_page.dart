import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'home_controller.dart';
import '../../shared/widgets/textform_widget.dart';
import '../auth/login/login_page.dart';
import 'widgets/card_project_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await Get.dialog(
          AlertDialog(
            title: const Text('Deseja sair do app?'),
            //content: const Text('Você será desconectado'),
            actions: [
              MaterialButton(
                child: const Text('Sim'),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
              MaterialButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Não'),
              ),
            ],
          ),
        );

        return result == true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Projetos'),
          leading: IconButton(
            icon: const Text('Sair'),
            onPressed: () async {
              Get.dialog(
                AlertDialog(
                  title: const Text('Confirmar saída?'),
                  content: const Text('Você será desconectado'),
                  actions: [
                    MaterialButton(
                      child: const Text('Sim'),
                      onPressed: () {
                        Get.find<GetStorage>().erase();
                        Get.offAllNamed(LoginPage.route);
                      },
                    ),
                    MaterialButton(
                      onPressed: Get.back,
                      child: const Text('Não'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<HomeController>(
                builder: (control) {
                  return TextFormWidget(
                    controller: control.searhController,
                    hintText: 'Procurar',
                    textInputAction: TextInputAction.search,
                    prefixIcon: const Icon(Icons.search),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<HomeController>(
                  builder: (control) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        control.projectsFiltered.length,
                        (index) {
                          return CardProjectWidget(
                            project: control.projectsFiltered[index],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.fetch(online: true),
          label: const Text('Atualizar dados'),
        ),
      ),
    );
  }
}
