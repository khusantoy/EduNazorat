part of "auth_bloc.dart";

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  final String passwordConfirmation;

  RegisterEvent(
    this.name,
    this.phone,
    this.password,
    this.passwordConfirmation,
  );
}