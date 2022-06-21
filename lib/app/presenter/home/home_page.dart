import 'package:fisplan_alupar/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './home_controller.dart';
import '../../shared/widgets/textform_widget.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<HomeController>(
              builder: (control) {
                return TextFormWidget(
                  controller: control.searhController,
                  hintText: 'Pesquisar',
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
                        final project = control.projectsFiltered[index];

                        return SizedBox(
                          width: context.width * .95,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 12.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    '${project.progress}% concluído',
                                    style: const TextStyle(
                                      color: appPrimaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    project.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (project.description!.isNotEmpty)
                                    const SizedBox(height: 12),
                                  Text(
                                    project.description ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
