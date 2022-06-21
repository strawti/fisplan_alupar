import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './home_controller.dart';
import '../../shared/widgets/textform_widget.dart';
import '../new_inspection/new_inspection_page.dart';
import 'widgets/card_project_widget.dart';

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
        onPressed: () {},
        label: const Text('Atualizar dados'),
      ),
    );
  }
}
