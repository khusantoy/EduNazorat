import 'package:crm_system/data/models/class/class.dart';
import 'package:crm_system/data/models/models.dart';
import 'package:crm_system/data/models/subject/subject.dart';

class Group {
  int id;
  String name;
  User mainTeacher;
  User assistantTeacher;
  Subject? subjectModel;
  List<User> students;
  List<Class> classes;

  Group({
    required this.id,
    required this.name,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.subjectModel,
    required this.students,
    required this.classes,
  });

  // Factory constructor for creating a Group from a map
  factory Group.fromMap(Map<String, dynamic> map) {
    List<User> students = (map['students'] as List).map((student) {
      return User.fromMap(student);
    }).toList();

    List<Class> classes = (map['classes'] as List).map((clas) {
      return Class.fromMap(clas);
    }).toList();

    return Group(
      id: map['id'],
      name: map['name'],
      mainTeacher: User.fromMap(map['main_teacher']),
      assistantTeacher: User.fromMap(map['assistant_teacher']),
      students: students,
      classes: classes,
      subjectModel: map['subject'] != null
          ? Subject.fromMap(map['subject'])
          : null, // If subject is null, Subject will be null
    );
  }
}
