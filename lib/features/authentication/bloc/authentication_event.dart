part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class LoginEvent extends AuthenticationEvent {
  final LoginRequest request;

  LoginEvent({required this.request});
}

final class RegisterEvent extends AuthenticationEvent {
  final RegisterRequest request;

  RegisterEvent({required this.request});
}

final class SocialLoginEvent extends AuthenticationEvent {
  final SocialLoginTypes type;

  SocialLoginEvent({required this.type});
}

final class CheckAuthStatusEvent extends AuthenticationEvent {}

final class LogoutEvent extends AuthenticationEvent {}
