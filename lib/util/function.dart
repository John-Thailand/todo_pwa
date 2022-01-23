import 'package:intl/intl.dart';

String convertDateTimeToString(DateTime dateTime) {
  return DateFormat.yMd("ja").format(dateTime);
}
