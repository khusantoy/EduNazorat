import 'package:crm_system/data/services/authentication/authentication_interceptor.dart';
import 'package:dio/dio.dart';

class GroupService {
  final Dio dio;

  GroupService() : dio = Dio() {
    dio.interceptors.add(AuthenticationInterceptor());
  }

  Future<void> addGroup(String name, int mainTeacherId, int assistantTeacherId,
      int subjectId) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "name": name,
        "main_teacher_id": mainTeacherId,
        "assistant_teacher_id": assistantTeacherId,
        "subject_id": subjectId
      };

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/groups',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Group added successfully');
      } else {
        print('Failed to add group: ${response.statusCode}');
        throw 'Failed to add group: ${response.statusCode}';
      }
    } catch (e) {
      print('Error adding group: $e');
    }
  }

  Future<Map<String, dynamic>> getGroups() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error adding group: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getStudentGroups() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/student/groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error adding group: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTeacherGroups() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/teacher/groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error adding group: $e');
      rethrow;
    }
  }

  Future<void> updateGroup(int groupId, String name, int mainTeacherId,
      int assistantTeacherId) async {
    try {
      final response = await dio.put(
        'http://millima.flutterwithakmaljon.uz/api/groups/$groupId',
        data: {
          'name': name,
          'main_teacher_id': mainTeacherId,
          'assistant_teacher_id': assistantTeacherId,
        },
      );

      if (response.statusCode == 200) {
        print('Group updated successfully');
      } else {
        print('Failed to update group: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      final response = await dio.delete(
        'http://millima.flutterwithakmaljon.uz/api/groups/$groupId',
      );

      if (response.statusCode == 200) {
        print('Group deleted successfully');
      } else {
        print('Failed to delete group: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addStudentsToGroup(int groupId, List studentIds) async {
    try {
      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/groups/$groupId/students',
        data: {
          'students': studentIds,
        },
      );

      if (response.statusCode == 200) {
        print('Students added successfully');
      } else {
        print('Failed to add students: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
