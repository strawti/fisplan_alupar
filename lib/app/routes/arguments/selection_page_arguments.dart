import 'package:fisplan_alupar/app/infra/models/defaults/item_selection_model.dart';

class SelectionPageArguments {
  SelectionPageArguments({required this.title, required this.items});

  final String title;
  final List<ItemSelectionModel> items;
}
