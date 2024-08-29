class Room {
  int id;
  String name;
  String description;
  int capacity;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.capacity,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      capacity: map['capacity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
    };
  }
}
