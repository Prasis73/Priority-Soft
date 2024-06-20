import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));

  // Normalize dates to remove time part
  DateTime normalizedDate = DateTime(date.year, date.month, date.day);
  DateTime normalizedNow = DateTime(now.year, now.month, now.day);
  DateTime normalizedTomorrow =
      DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

  if (normalizedDate == normalizedNow) {
    return 'Today';
  } else if (normalizedDate == normalizedTomorrow) {
    return 'Tomorrow';
  } else {
    return DateFormat('dd/MM').format(date);
  }
}
