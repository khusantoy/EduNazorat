part of "auth_bloc.dart";

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  final String passwordConfirmation;

  RegisterEvent({
    required this.name,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });
}
