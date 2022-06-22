import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'textform_widget.dart';

class SearchWidget<T extends GetxController> extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<T>(
        builder: (control) {
          return TextFormWidget(
            controller: controller,
            hintText: 'Procurar',
            textInputAction: TextInputAction.search,
            prefixIcon: const Icon(Icons.search),
          );
        },
      ),
    );
  }
}
