import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String name;

  const Role({
    required this.id,
    required this.name,
  });

  Role copyWith({
    int? id,
    String? name,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory Role.teacher() {
    return const Role(id: 2, name: 'teacher');
  }

  @override
  List<Object> get props => [id, name];
}
