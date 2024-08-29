import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // SharedPreferences dan tokenni olish
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString("token");

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    } else {
      print("Token topilmadi");
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Response: ${response.statusCode} ${response.data}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("Error: ${err.message}");
    return handler.next(err);
  }
}
