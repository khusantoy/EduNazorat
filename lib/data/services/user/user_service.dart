import 'package:crm_system/data/models/models.dart';
import 'package:dio/dio.dart';
import 'package:crm_system/utils/network/dio_client.dart';

abstract class UserServiceInterface {
  Future<User> getUser();
}

class UserService extends UserServiceInterface {
  final dio = DioClient.dio;

  @override
  Future<User> getUser() async {
    try {
      final response = await dio.get('/user');
      return User.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
