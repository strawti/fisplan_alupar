class ItemSelectionModel<T> {
  final T item;
  bool isChecked;
  final String title;

  ItemSelectionModel({
    required this.item,
    this.isChecked = false,
    required this.title,
  });
}
