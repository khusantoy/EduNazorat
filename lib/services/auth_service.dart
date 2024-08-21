import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio) {
    dio.options = BaseOptions(
      baseUrl: "http://millima.flutterwithakmaljon.uz/api/",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  Future<String> register({
    required String name,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dio.post("register", data: {
        'name': name,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      print(response);
      return response.data['data']['token'];
    } catch (e) {
      if (e is DioException) {
        print("---------DioException Xatolik------------");
        print("Status kodi: ${e.response?.statusCode}");
        print("Ma'lumot: ${e.response?.data}");
        print("So'rov ma'lumotlari: ${e.requestOptions}");
      } else {
        print("---------Boshqa Xatolik------------");
        print(e.toString());
      }
      rethrow;
    }
  }
}
