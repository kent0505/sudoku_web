import 'dart:developer' as developer;

import 'package:intl/intl.dart';

void logger(Object message) {
  developer.log(message.toString());
}

int getTimestamp() => DateTime.now().millisecondsSinceEpoch;

String timestampToString(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('dd.MM.yyyy').format(date);
}

String formatTimer(Duration d) {
  final minutes = d.inMinutes % 60;
  final seconds = d.inSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String durationToString(Duration d) {
  final minutes = d.inMinutes.remainder(60);
  final seconds = d.inSeconds.remainder(60);
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return '${twoDigits(minutes)}:${twoDigits(seconds)}';
}
