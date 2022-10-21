import 'package:intl/intl.dart';

double getVideoProgress(Duration current, Duration total) {
  final percentage = (current.inSeconds / total.inSeconds * 100).truncate();
  return double.parse(percentage.toStringAsFixed(2));
}

getDurationfromString(String duration) {
  var format = DateFormat("HH:mm:ss");
  var one = format.parse(duration);
  String res = '';
  if (one.minute < 10) {
    res = '0${one.minute}m';
  } else {
    res = '${one.minute}m';
  }
  if (one.second < 9) {
    res += ' 0${one.second}s';
  } else {
    res += ' ${one.second}s';
  }
  return res;
}
