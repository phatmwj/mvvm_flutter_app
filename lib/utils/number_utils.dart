import 'package:intl/intl.dart';

class NumberUtils{
  static String formatMoneyToString(double money){
    NumberFormat formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(money);
  }

  static String formatDate(String date){
    DateFormat inputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    DateTime dateTime = inputFormat.parse(date).add(Duration(hours: 7));
    return inputFormat.format(dateTime);
  }

  static String formatDistance(double distance){
    return (distance/1000).toStringAsFixed(2);
  }
}