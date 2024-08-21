import 'package:crm_system/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final token = await authService.register(
        name: event.name,
        phone: event.phone,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );

      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
