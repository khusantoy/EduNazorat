import 'package:dio/dio.dart';
import 'package:millima/data/services/authentication/local_authentication_service.dart';
import 'package:millima/utils/di/locator.dart';

class DioClient {
  static final _dio = Dio(
    BaseOptions(baseUrl: "http://millima.flutterwithakmaljon.uz/api"),
  )..interceptors.add(NetworkInterceptor());

  static Dio get dio {
    return _dio;
  }
}

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final auth = getIt.get<LocalAuthenticationService>().getAuth();
    if (auth != null) {
      options.headers = {
        "Authorization": "Bearer ${auth.token}",
      };
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // print(err.response?.data);
    super.onError(err, handler);
  }
}
