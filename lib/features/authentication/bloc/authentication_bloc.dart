import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/data/services/user/user_service.dart';
import 'package:millima/domain/authentication_repository/authentication_repository.dart';
import 'package:millima/utils/di/locator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

enum SocialLoginTypes { google, facebook, github }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState()) {
    on<LoginEvent>(_onLogin);
    on<SocialLoginEvent>(_onSocialLogin);
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
      final user = await getIt.get<UserService>().getUser();
      emit(state.copyWith(
        status: AuthenticationStatus.authenticated,
        user: user,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void _onSocialLogin(
    SocialLoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      SocialLoginRequest? request;
      switch (event.type) {
        case SocialLoginTypes.google:
          const List<String> scopes = <String>['email'];
          final googleSignIn = GoogleSignIn(scopes: scopes);
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            request = SocialLoginRequest(
              name: googleUser.displayName ?? '',
              email: googleUser.email,
            );
          }
          break;
        case SocialLoginTypes.facebook:
          final result = await FacebookAuth.instance.login();
          if (result.status == LoginStatus.success) {
            final userData = await FacebookAuth.i.getUserData(
              fields: "name,email",
            );
            request = SocialLoginRequest(
              name: userData['name'] ?? '',
              email: userData['email'],
            );
          }
          break;
        default:
          return;
      }

      if (request != null) {
        await _authenticationRepository.socialLogin(request);
        final user = await getIt.get<UserService>().getUser();
        emit(state.copyWith(
          status: AuthenticationStatus.authenticated,
          user: user,
          isLoading: false,
        ));
      } else {
        throw ('User not found');
      }
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
      final user = await getIt.get<UserService>().getUser();
      emit(state.copyWith(
        status: AuthenticationStatus.authenticated,
        user: user,
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
      User? user;
      if (isLoggedIn) {
        user = await getIt.get<UserService>().getUser();
      }
      emit(state.copyWith(
        status: isLoggedIn
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
        user: user,
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
