import 'package:crm_system/data/models/role/role.dart';
import 'package:equatable/equatable.dart';

import '../models.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String? photo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int roleId;
  final Role role;
  const User({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.role,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? roleId,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      roleId: roleId ?? this.roleId,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'photo': photo});
    result.addAll({'role_id': roleId});
    result.addAll({'role': role.toMap()});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photo: map['photo'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      roleId: map['role_id']?.toInt() ?? 0,
      role: Role.fromMap(map['role']),
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      phone,
      photo,
      roleId,
      role,
    ];
  }
}
