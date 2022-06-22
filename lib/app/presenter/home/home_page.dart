import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/search_widget.dart';
import 'home_controller.dart';
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
            onPressed: () {
              Get.dialog(DisconnectUserDialogWidget(
                confirmOnPressed: controller.disconnectUser,
              ));
            },
          ),
        ),
        body: Column(
          children: [
            SearchWidget<HomeController>(
              controller: controller.searchController,
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

class DisconnectUserDialogWidget extends StatelessWidget {
  final void Function()? confirmOnPressed;

  /// Null case Get.back is used
  final void Function()? cancelOnPressed;

  const DisconnectUserDialogWidget({
    Key? key,
    this.confirmOnPressed,
    this.cancelOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar saída?'),
      content: const Text('Você será desconectado'),
      actions: [
        MaterialButton(
          onPressed: confirmOnPressed,
          child: const Text('Sim'),
        ),
        MaterialButton(
          onPressed: cancelOnPressed ?? Get.back,
          child: const Text('Não'),
        ),
      ],
    );
  }
}
