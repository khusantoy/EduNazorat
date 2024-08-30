class WeekDay {
  String room;
  String startTime;
  String endTime;

  WeekDay({
    required this.room,
    required this.startTime,
    required this.endTime,
  });

  factory WeekDay.fromMap(Map<String, dynamic> map) {
    return WeekDay(
      room: map['room'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }
}