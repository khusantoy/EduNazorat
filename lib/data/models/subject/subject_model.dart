class SubjectModel {
  int id;
  String name;
  

  SubjectModel({required this.id, required this.name});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
