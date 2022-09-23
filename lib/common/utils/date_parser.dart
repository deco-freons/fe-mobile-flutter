import 'package:intl/intl.dart';

class DateParser {
  static List<String> parseEventDate(String date) {
    String formattedDate =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(date));
    return formattedDate.split(' ');
  }

  static String parseBirthDate(String date) {
    String formattedDate =
        DateFormat('dd MMMM yyyy').format(DateTime.parse(date));
    return formattedDate;
  }
}
