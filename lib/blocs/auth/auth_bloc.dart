// import 'dart:developer';

// import 'package:crm_system/data/models/user.dart';
// import 'package:equatable/equatable.dart';
// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;
//   final _fcmService = FCMService();
//   final _dioUserService = DioUserService();

//   AuthBloc({required this.authService}) : super(AuthInitial()) {
//     on<AuthRegister>(_onRegister);
//     on<AuthSignIn>(_onSignIn);
//     on<AuthLogout>(_onLogout);
//     on<CheckTokenExpiry>(_onCheckTokenExpiry);
//     on<AuthResetPassword>(_onResetPassword);
//   }

//   Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final user = await authService.register(event.email, event.password);
//       final token = await _fcmService.getToken();
//       _dioUserService.addUser(
//         event.username,
//         event.email,
//         token,
//         user.localId,
//       );
//       emit(AuthAuthenticated(user));
//     } on DioException catch (e) {
//       emit(AuthError(e.response?.data["error"]['message']));
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onResetPassword(
//       AuthResetPassword event, Emitter<AuthState> emit) async {
//     try {
//       await authService.resetPassword(event.email);
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   void _onCheckTokenExpiry(
//     CheckTokenExpiry event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());
//     try {
//       final user = await authService.checkTokenExpiry();
//       if (user != null) {
//         emit(AuthAuthenticated(user));
//       } else {
//         emit(AuthUnauthenticated());
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final user = await authService.signIn(event.email, event.password);
//       emit(AuthAuthenticated(user));
//     } on DioException catch (e) {
//       emit(AuthError(e.response?.data["error"]['message']));
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       await authService.logout();
//       emit(AuthUnauthenticated());
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
// }