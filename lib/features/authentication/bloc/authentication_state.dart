part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, isLoading, error];
}
