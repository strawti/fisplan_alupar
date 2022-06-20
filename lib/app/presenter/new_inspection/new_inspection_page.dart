import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './new_inspection_controller.dart';

class NewInspectionPage extends GetView<NewInspectionController> {
    
    const NewInspectionPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('NewInspectionPage'),),
            body: Container(),
        );
    }
}