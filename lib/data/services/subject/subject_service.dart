import 'package:crm_system/data/services/authentication/authentication_interceptor.dart';
import 'package:dio/dio.dart';

class SubjectService {
  final Dio dio;

  SubjectService() : dio = Dio() {
    dio.interceptors.add(AuthenticationInterceptor());
  }

  Future<void> addSubject(String name) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "name": name,
      };

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/subjects',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Subject added successfully');
      } else {
        print('Failed to add Subject: ${response.statusCode}');
        throw 'Failed to add Subject: ${response.statusCode}';
      }
    } catch (e) {
      print('Error adding Subject: $e');
    }
  }

  Future<Map<String, dynamic>> getSubjects() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/subjects',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error getting Subjects: $e');
      rethrow;
    }
  }

  Future<void> updateSubject(int subjectId, String name) async {
    try {
      final response = await dio.put(
        'http://millima.flutterwithakmaljon.uz/api/subjects/$subjectId',
        data: {
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        print('Subject updated successfully');
      } else {
        print('Failed to update Subject: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteSubject(int subjectId) async {
    try {
      final response = await dio.delete(
        'http://millima.flutterwithakmaljon.uz/api/subjects/$subjectId',
      );

      if (response.statusCode == 200) {
        print('Subject deleted successfully');
      } else {
        print('Failed to delete Subject: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
