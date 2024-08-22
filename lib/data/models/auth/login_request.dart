import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String phone;
  final String password;

  const LoginRequest({required this.phone, required this.password});

  LoginRequest copyWith({
    String? phone,
    String? password,
  }) {
    return LoginRequest(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'phone': phone});
    result.addAll({'password': password});

    return result;
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  List<Object> get props => [phone, password];
}