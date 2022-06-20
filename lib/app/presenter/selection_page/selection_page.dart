import 'package:fisplan_alupar/app/presenter/selection_page/selection_controller.dart';
import 'package:fisplan_alupar/app/shared/widgets/textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({Key? key}) : super(key: key);

  static const route = '/selection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.find<SelectionController>().routeArguments.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<SelectionController>(
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
              child: GetBuilder<SelectionController>(
                builder: (control) {
                  return Column(
                    children: List.generate(
                      control.itemsFiltered.length,
                      (index) {
                        final item = control.itemsFiltered[index];
                        return ListTile(
                          title: Text(item.title),
                          onTap: () => Get.back(result: item),
                          leading: Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            value: item.isChecked,
                            onChanged: (value) => Get.back(result: item),
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
    );
  }
}