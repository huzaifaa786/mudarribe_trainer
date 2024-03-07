import 'package:intl/intl.dart';

String timeConverstion(String date) {
  int timestamp = int.parse(date);
  DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = DateFormat('dd/MM/y').format(date1);
  return formattedDate;
}

String? calculateNewDate(String date, String duration) {
  DateTime? newDate;
  int timestamp = int.parse(date);

  DateTime currentDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
  if (duration.contains("One Month")) {
    newDate = currentDate.add(Duration(days: 30));
  } else if (duration.contains("Three Months")) {
    newDate = currentDate.add(Duration(days: 90));
  } else if (duration.contains("Six Months")) {
    newDate = currentDate.add(Duration(days: 180));
  } else if (duration.contains("Twelve Months")) {
    newDate = currentDate.add(Duration(days: 365));
  }
  // You can add more conditions for other durations as needed.

  return DateFormat('dd/MM/yyyy').format(newDate!);
}

bool hideAndShowButtonOnTime(String date, String duration) {
  DateTime currentDate = DateTime.now();
  int timestamp = int.parse(date);
  DateTime newDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

  if (duration.contains("One Month")) {
    newDate = newDate.add(Duration(days: 30));
  } else if (duration.contains("Three Months")) {
    newDate = newDate.add(Duration(days: 90));
  } else if (duration.contains("Six Months")) {
    newDate = newDate.add(Duration(days: 180));
  } else if (duration.contains("Twelve Months")) {
    newDate = newDate.add(Duration(days: 365));
  }
  // You can add more conditions for other durations as needed.

  return newDate.isAfter(currentDate);
}
