part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final bool isLoading;
  final Object? error;

  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.isLoading = false,
    this.error,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    bool? isLoading,
    Object? error,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, isLoading, error];
}
