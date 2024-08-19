part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const AuthRegister(
    this.email,
    this.password,
    this.username,
  );

  @override
  List<Object> get props => [email, password];
}

class AuthResetPassword extends AuthEvent {
  final String email;

  const AuthResetPassword(this.email);

  @override
  List<Object> get props => [email];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class CheckTokenExpiry extends AuthEvent {}

class AuthLogout extends AuthEvent {}