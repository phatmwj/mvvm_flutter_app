import 'package:intl/intl.dart';

class DatetimeUtils{
  static String convertToUTC(String dateString) {
    final inputFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    final outputFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    DateTime? date;
    try {
      date = inputFormat.parse(dateString);
    } catch (e) {
      print(e);
    }
    return outputFormat.format(date!.toUtc());
  }

  static String dateStartFormat(DateTime date) {
    // Đặt giờ, phút, giây về 00:00:00
    DateTime adjustedDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    // Định dạng lại thời gian với định dạng mong muốn
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(adjustedDate);
  }

  static String dateEndFormat(DateTime date) {
    // Đặt giờ, phút, giây về 23:59:59
    DateTime adjustedDate = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    // Định dạng lại thời gian với định dạng mong muốn
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(adjustedDate);
  }

  static String startWeekFormat(DateTime date) {
    DateFormat outputDateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");

    // Lấy ngày đầu tiên của tuần
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Đặt giờ, phút, giây, mili giây về 0 để lấy ngày đầu tiên của tuần
    firstDayOfWeek = DateTime(firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day, 0, 0, 0, 0);

    // In ra kết quả
    print("Ngày đầu tiên của tuần: $firstDayOfWeek");
    return outputDateFormat.format(firstDayOfWeek);
  }

  static String endWeekFormat(DateTime date) {
    DateFormat outputDateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");

    // Lấy ngày cuối cùng của tuần
    DateTime lastDayOfWeek = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));

    // Đặt giờ, phút, giây, mili giây về 23:59:59 để lấy ngày cuối cùng của tuần
    lastDayOfWeek = DateTime(lastDayOfWeek.year, lastDayOfWeek.month, lastDayOfWeek.day, 23, 59, 59, 999);

    return outputDateFormat.format(lastDayOfWeek);
  }

  static String startMonthFormat(DateTime date) {
    DateFormat outputDateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");

    // Đặt ngày trong tháng về ngày đầu tiên của tháng
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1, 0, 0, 0, 0);

    return outputDateFormat.format(firstDayOfMonth);
  }

  static String endMonthFormat(DateTime date) {
    DateFormat outputDateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");

    // Đặt ngày trong tháng về ngày cuối cùng của tháng
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);

    return outputDateFormat.format(lastDayOfMonth);
  }



}