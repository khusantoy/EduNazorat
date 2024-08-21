import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> register({
    required String name,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await dio.post("/register", data: {
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    
    return response.data['token'];
  }
}
