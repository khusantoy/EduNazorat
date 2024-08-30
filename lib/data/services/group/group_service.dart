// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/utils/network/dio_client.dart';

class GroupService {
  final dio = DioClient.dio;

  Future<void> addGroup(String name, int mainTeacherId, int assistantTeacherId,
      int subjectId) async {
    try {
      final data = {
        "name": name,
        "main_teacher_id": mainTeacherId,
        "assistant_teacher_id": assistantTeacherId,
        "subject_id": subjectId,
      };

      final response = await dio.post(
        '/groups',
        data: data,
      );

      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Group added successfully');
      } else {
        throw 'Failed to add group: ${response.statusCode}';
      }
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroups() async {
    try {
      final response = await dio.get(
        '/groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGroup(int groupId, String name, int mainTeacherId,
      int assistantTeacherId, int subjectId) async {
    try {
      final response = await dio.put(
        '/groups/$groupId',
        data: {
          'name': name,
          'main_teacher_id': mainTeacherId,
          'assistant_teacher_id': assistantTeacherId,
          'subject_id': subjectId,
        },
      );

      if (response.statusCode == 200) {
        print('Group updated successfully');
      } else {
        print('Failed to update group: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> addStudentsToGroup(int groupId, List studentIds) async {
    try {
      final response = await dio.post(
        '/groups/$groupId/students',
        data: {
          'students': studentIds,
        },
      );

      if (response.statusCode == 200) {
        print('Students added successfully');
      } else {
        print('Failed to add students: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<GroupModel>> getStudentGroups() async {
    try {
      final response = await dio.get("/student/groups");

      List<GroupModel> loadedGroups = [];

      for (var group in response.data['data']) {
        loadedGroups.add(GroupModel.fromJson(group));
      }

      return loadedGroups;
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<GroupModel>> getTeacherGroups() async {
    try {
      final response = await dio.get("/teacher/groups");

      print("teacher response: ${response.data['data']}");

      List<GroupModel> loadedGroups = [];

      for (var group in response.data['data']) {
        loadedGroups.add(GroupModel.fromJson(group));
      }

      return loadedGroups;
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (error) {
      rethrow;
    }
  }
}
