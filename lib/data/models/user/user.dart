import 'package:equatable/equatable.dart';

import '../models.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String? photo;
  final int roleId;
  final Role role;
  const User({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.photo,
    required this.roleId,
    required this.role,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    int? roleId,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
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
    result.addAll({'roleId': roleId});
    result.addAll({'role': role.toMap()});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photo: map['photo'] != null
          ? "http://millima.flutterwithakmaljon.uz/storage/avatars/${map['photo']}"
          : "https://avatars.mds.yandex.net/i?id=c2f3c4d99b491657b188c1ff06a764845d7ea559-5749428-images-thumbs&n=13",
      roleId: map['role_id']?.toInt() ?? 1,
      role: map['role'] == null ? Role.teacher() : Role.fromMap(map['role']),
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
