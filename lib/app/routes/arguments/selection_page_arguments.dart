import '../../infra/models/defaults/item_selection_model.dart';

class SelectionPageArguments<T> {
  SelectionPageArguments({required this.title, required this.items});

  final String title;
  final List<ItemSelectionModel<T>> items;
}
