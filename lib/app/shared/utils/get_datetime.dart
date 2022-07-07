String formatDateTimeForString(DateTime? dateTime) {
  if (dateTime == null) {
    return 'Não informado';
  }

  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final year = dateTime.year.toString();
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final second = dateTime.second.toString().padLeft(2, '0');
  return "$day/$month/$year $hour:$minute:$second";
}

DateTime formatStringForDateTime(String value) {
  final valueAsList =
      value.replaceAll(':', '-').replaceAll(' ', '-').split('-');

  int year = int.parse(valueAsList[0]);
  int month = int.parse(valueAsList[1]);
  int day = int.parse(valueAsList[2]);

  int hours = int.parse(valueAsList[2]);
  int minutes = int.parse(valueAsList[3]);
  int seconds = int.parse(valueAsList[4]);

  return DateTime(year, month, day, hours, minutes, seconds);
}
