import 'package:crm_system/data/models/auth/login_request.dart';
import 'package:crm_system/data/models/auth/register_request.dart';
import 'package:crm_system/domain/authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LogoutEvent>(_onLogout);
  }

  void _onLogin(
    LoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _authenticationRepository.login(event.request);
      emit(state.copyWith(
        status: AuthenticationStatus.authenticated,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void _onRegister(
    RegisterEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _authenticationRepository.register(event.request);
      emit(state.copyWith(
        status: AuthenticationStatus.authenticated,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void _onLogout(
    LogoutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _authenticationRepository.logout();
      emit(state.copyWith(
        status: AuthenticationStatus.unauthenticated,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final isLoggedIn = await _authenticationRepository.checkAuthStatus();
      emit(state.copyWith(
        status: isLoggedIn
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
