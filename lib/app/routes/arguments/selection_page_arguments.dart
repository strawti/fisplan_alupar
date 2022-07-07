import '../../infra/models/defaults/item_selection_model.dart';

class SelectionPageArguments<T> {
  SelectionPageArguments({
    required this.title,
    required this.items,
    this.isMultipleSelection = false,
  });

  final String title;
  final List<ItemSelectionModel<T>> items;
  final bool isMultipleSelection;
}
