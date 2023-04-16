part of '../custom_extensions.dart';

extension XDateTime on DateTime {
  String get formattedTime {
    final formatted = '${hour.toString()}:${minute.toString().padLeft(2, '0')}';

    return formatted;
  }

  String get formattedDate {
    final formattedDate = "${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString()}";

    return formattedDate;
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final n = DateTime.now().subtract(const Duration(days: 1));
    return year == n.year && month == n.month && day == n.day;
  }
}
