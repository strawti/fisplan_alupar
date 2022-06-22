import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/defaults/item_selection_model.dart';
import '../../routes/arguments/selection_page_arguments.dart';

class SelectionController extends GetxController {
  SelectionController() {
    assert(
      Get.arguments is SelectionPageArguments,
      "Passe SelectionPageArguments nos argumentos da rota",
    );

    routeArguments = Get.arguments;
  }

  late SelectionPageArguments routeArguments;

  @override
  void onReady() {
    super.onReady();

    searchController.addListener(() {
      itemsFiltered.clear();

      for (var item in routeArguments.items) {
        if (item.title.toLowerCase().contains(searchText)) {
          itemsFiltered.add(item);
        }
      }

      update();
    });

    itemsFiltered = routeArguments.items.toList();
    itemsFiltered.sort((a, b) => a.isChecked ? -1 : 1);
    update();
  }

  @override
  void onClose() {
    super.onClose();

    searchController.dispose();
  }

  final searchController = TextEditingController();
  String get searchText => searchController.text.trim().toLowerCase();

  List<ItemSelectionModel> itemsFiltered = [];
}
