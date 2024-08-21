import 'package:crm_system/blocs/auth/interceptor/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio dio;

  AuthBloc(this.dio) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await dio.post("/login", data: {
        'name': event.name,
        'phone': event.phone,
        'password': event.password,
        'password_confirmation': event.passwordConfirmation,
      });

      final token = response.data['token'];
      dio.interceptors.add(AuthInterceptor(token));
      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
