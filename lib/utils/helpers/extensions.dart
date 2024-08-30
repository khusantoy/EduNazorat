import 'package:flutter/material.dart';

extension TimeOfDayX on TimeOfDay {
  String formatTimeOfDay() {
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
