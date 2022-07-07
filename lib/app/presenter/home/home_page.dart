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
            title: 'Deseja sair do app?',
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
              icon: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  const Icon(Icons.download),
                  GetBuilder<HomeController>(
                    didChangeDependencies: (state) {
                      HomeController.to.getInspectionsUnsynch();
                    },
                    builder: (control) {
                      return Visibility(
                        visible: control.hasInspectionsUnsynch,
                        replacement: const SizedBox.shrink(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const ColoredBox(
                            color: Colors.orange,
                            child: SizedBox(
                              width: 10,
                              height: 10,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
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
                    if (control.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

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
      ),
    );
  }
}
