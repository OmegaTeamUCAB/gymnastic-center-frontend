import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays == 1) {
    return 'Yesterday, ${DateFormat.jm().format(dateTime)}';
  } else if (difference.inDays < 7) {
    return '${DateFormat.E().format(dateTime)} ${DateFormat.jm().format(dateTime)}';
  } else {
    return DateFormat.yMd().format(dateTime);
  }
}
