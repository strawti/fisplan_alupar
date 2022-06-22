import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/alert_dialog_widget.dart';
import '../../shared/widgets/search_widget.dart';
import '../download_data/download_data_page.dart';
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
          AlertDialogWidget(
            title: 'Confirmar saída?',
            content: 'Você será desconectado',
            confirmOnPressed: () => Get.back(result: true),
            cancelOnPressed: () => Get.back(result: false),
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
              Get.dialog(AlertDialogWidget(
                title: 'Confirmar saída?',
                content: 'Você será desconectado',
                confirmOnPressed: controller.disconnectUser,
              ));
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                Get.toNamed(DownloadDataPage.route);
              },
            ),
          ],
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
