import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String name;
  final String phone;
  final String password;
  final String passwordConfirmation;
  final int? roleId;

  const RegisterRequest({
    required this.name,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    this.roleId,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        password,
        passwordConfirmation,
        roleId,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': passwordConfirmation});
    result.addAll({'role_id': roleId});

    return result;
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      passwordConfirmation: map['passwordConfirmation'] ?? '',
      roleId: map['role_id'] ?? '',
    );
  }
}
