

import 'package:intl/intl.dart';

getDayName(String date){
  var dateTime1 = DateFormat('y-M-d').parse(date);
  return DateFormat.EEEE().format(dateTime1);
}