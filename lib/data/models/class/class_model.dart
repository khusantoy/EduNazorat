class ClassModel {
  int id;
  String roomName;
  String dayName;
  String startTime;
  String endTime;

  ClassModel({
    required this.id,
    required this.roomName,
    required this.dayName,
    required this.startTime,
    required this.endTime,
  });

  // Factory constructor for creating a ClassModel from a json
  factory ClassModel.fromjson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      roomName: json['room']['name'],
      dayName: json['day']['name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  // Method to convert ClassModel to a json
  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'room_id': roomName,
      'day_id': dayName,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
