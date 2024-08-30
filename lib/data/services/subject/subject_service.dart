// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:millima/data/models/subject/subject_model.dart';
import 'package:millima/utils/network/dio_client.dart';

class SubjectService {
  final dio = DioClient.dio;

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final response = await dio.get("/subjects");

      print(response.data);
      List<SubjectModel> loadedSubjects = [];

      for (var subject in response.data['data']) {
        loadedSubjects.add(SubjectModel.fromJson(subject));
      }

      return loadedSubjects;
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<SubjectModel> getOneSubject(String subjectId) async {
    try {
      final response = await dio.get("/subjects/$subjectId");

      print(response.data);

      return SubjectModel.fromJson(response.data['data']);
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addSubject(String subjectName) async {
    try {
      final response = await dio.post("/subjects", data: {'name': subjectName});

      if (response.data['success'] != true) {
        throw "Failed to add subject";
      }
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editSubject(int subjectId, String newName) async {
    print(newName);
    try {
      final response = await dio.put("/subjects/$subjectId?name=$newName");

      print(response.data);

      if (response.data['success'] != true) {
        throw "Failed to update subject";
      }
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSubject(int subjectId) async {
    try {
      final response = await dio.delete("/subjects/$subjectId");

      if (response.data['success'] != true) {
        throw "Failed to delete subject";
      }
    } on DioException catch (error) {
      throw error.response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
