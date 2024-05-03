import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 5) {
    return '${difference.inHours} h ago';
  } else if (difference.inDays == 1) {
    return 'Yesterday, ${DateFormat.jm().format(dateTime)}';
  } else if (difference.inDays < 7) {
    return '${DateFormat.E().format(dateTime)} ${DateFormat.jm().format(dateTime)}';
  } else {
    return DateFormat.yMd().format(dateTime);
  }
}
