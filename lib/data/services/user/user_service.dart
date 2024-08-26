import 'package:crm_system/data/models/models.dart';
import 'package:dio/dio.dart';
import 'package:crm_system/utils/network/dio_client.dart';

abstract class UserServiceInterface {
  Future<User> getUser();
  Future<List<User>> getStudents();
  Future<List<User>> getTeachers();
  Future<List<User>> getAdmins();
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

  @override
  Future<List<User>> getStudents() async {
    try {
      final response = await dio.get('/users', queryParameters: {"role_id": 1});

      List<User> students = [];

      for (var element in response.data['data']) {
        students.add(User.fromMap(element));
      }

      return students;
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getTeachers() async {
    try {
      final response = await dio.get('/users', queryParameters: {"role_id": 2});

      List<User> teachers = [];

      for (var element in response.data['data']) {
        teachers.add(User.fromMap(element));
      }

      return teachers;
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getAdmins() async {
    try {
      final response = await dio.get('/users', queryParameters: {"role_id": 3});

      List<User> admins = [];

      for (var element in response.data['data']) {
        admins.add(User.fromMap(element));
      }

      return admins;
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
