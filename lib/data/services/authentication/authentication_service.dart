import 'package:dio/dio.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/utils/network/dio_client.dart';

abstract class AuthenticationServiceInterface {
  Future<AuthenticationResponse> login(LoginRequest request);
  Future<AuthenticationResponse> socialLogin(SocialLoginRequest request);
  Future<AuthenticationResponse> register(RegisterRequest request);
  Future<void> logout();
}

class AuthenticationService extends AuthenticationServiceInterface {
  final dio = DioClient.dio;

  @override
  Future<AuthenticationResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '/login',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthenticationResponse> socialLogin(SocialLoginRequest request) async {
    try {
      final response = await dio.post(
        '/social-login',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest request) async {
    try {
      final response = await dio.post(
        '/register',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/logout');
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
