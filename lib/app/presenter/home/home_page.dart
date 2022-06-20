import 'package:fisplan_alupar/app/infra/models/defaults/item_selection_model.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/new_inspection_bindings.dart';
import 'package:fisplan_alupar/app/presenter/selection_page/selection_page.dart';
import 'package:fisplan_alupar/app/routes/arguments/selection_page_arguments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './home_controller.dart';

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

            NewInspectionBindings();

            Get.toNamed(
              SelectionPage.route,
              arguments: SelectionPageArguments(
                title: 'Tipo de Instalação',
                items: [
                  // Listas de itens relacionados com o contexto,
                  ItemSelectionModel(
                    item: '',
                    isChecked: false,
                    title: 'ABC da Amazônia',
                  ),
                  ItemSelectionModel(
                    item: '',
                    isChecked: true,
                    title: 'Pato no Tucupi',
                  ),
                ],
              ),
            );
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
