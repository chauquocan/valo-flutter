import 'package:intl/intl.dart';

String formatDate(String thoigian) {
  final now = DateTime.now();
  final time = DateTime.parse(thoigian);
  var sendTime;
  if (time.year < now.year) {
    sendTime = DateFormat.yMMMMd().format(time);
  } else {
    if (now.difference(time).inHours < 6) {
      sendTime = DateFormat('HH:mm').format(time);
    } else if (time.day == now.day) {
      sendTime = 'Today';
      // + DateFormat('jm').format(time);
    } else if (now.difference(time).inDays == 1) {
      sendTime = 'Yesterday';
      //  + DateFormat('jm').format(time);
    } else {
      sendTime = DateFormat('dd/MM').format(time);
    }
  }
  return sendTime;
}
