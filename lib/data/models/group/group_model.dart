import 'package:millima/data/models/models.dart';

class GroupModel {
  int id;
  String name;
  User mainTeacher;
  User assistantTeacher;
  List<User> students;
  SubjectModel? subject;
  List<ClassModel> classes;

  GroupModel({
    required this.id,
    required this.name,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.students,
    required this.subject,
    required this.classes,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      mainTeacher: User.fromMap(json['main_teacher']),
      assistantTeacher: User.fromMap(json['assistant_teacher']),
      students: json['students'] == null
          ? []
          : List.from(json['students'].map((user) => User.fromMap(user))),
      subject: json['subject'] == null
          ? null
          : SubjectModel.fromJson(json['subject']),
      classes: json['classes'] == null
          ? []
          : (json['classes'] as List).map((clas) {
              return ClassModel.fromjson(clas);
            }).toList(),
    );
  }
}
