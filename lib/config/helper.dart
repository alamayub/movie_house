import 'package:intl/intl.dart';

double getVideoProgress(Duration current, Duration total) {
  final percentage = (current.inSeconds / total.inSeconds * 100).truncate();
  return double.parse(percentage.toStringAsFixed(2));
}

getDurationFromString(String duration) {
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

getDateWithTime(int a) {
  var old = DateTime.fromMillisecondsSinceEpoch(a);
  var now = DateTime.now();
  var diff = now.difference(old);
  // log('Difference $diff');
  // log('Current ${now.day - date.subtract(const Duration(days: 1)).day}');
  // return DateFormat.yMMMd().add_jm().format(date);
  var time = DateFormat.jm().format(old);
  // log('Day Diff ${diff.inDays}, ${diff.inHours}, ${diff.inMinutes}');
  var res = '';
  if (now.day == old.day) {
    res = 'Today $time';
  } else if (diff.inDays == 0) {
    res = 'Yesterday, $time';
  } else {
    res = '${diff.inDays} days ago, $time';
  }
  return res;
}
