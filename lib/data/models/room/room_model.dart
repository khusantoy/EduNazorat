class RoomModel {
  int id;
  String name;
  String description;
  int capacity;

  RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.capacity,
  });

  // Convert a JSON map to a RoomModel instance
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      capacity: json['capacity'],
    );
  }

  // Convert a RoomModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
    };
  }
}
