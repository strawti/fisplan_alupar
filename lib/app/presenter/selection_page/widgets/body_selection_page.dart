import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/search_widget.dart';
import '../selection_controller.dart';

class BodySelectionPage extends StatelessWidget {
  const BodySelectionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchWidget<SelectionController>(
          controller: Get.find<SelectionController>().searchController,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: GetBuilder<SelectionController>(
              builder: (control) {
                if (control.itemsFiltered.isEmpty) {
                  return const Center(
                    child: Text('Nenhum item encontrado'),
                  );
                }

                return Column(
                  children: List.generate(
                    control.itemsFiltered.length,
                    (index) {
                      final item = control.itemsFiltered[index];
                      return ListTile(
                        title: Text(item.title),
                        onTap: () => control.selectItem(item),
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          value: item.isChecked,
                          onChanged: (value) => control.selectItem(item),
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
    );
  }
}
