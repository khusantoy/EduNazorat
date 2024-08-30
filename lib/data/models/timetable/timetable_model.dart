
import 'package:millima/data/models/timetable/week_day.dart';

class Timetable {
  Map<String, List<WeekDay>> weekDays;

  Timetable({required this.weekDays});

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      weekDays: map.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => WeekDay.fromMap(e)).toList(),
        ),
      ),
    );
  }
}