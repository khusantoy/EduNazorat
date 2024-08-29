class Subject {
  int id;
  String name;

  Subject({
    required this.id,
    required this.name,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      name: map['name'],
    );
  }
}
