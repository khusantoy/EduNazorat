import 'dart:io';

import 'package:dio/dio.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/utils/network/dio_client.dart';

abstract class UserServiceInterface {
  Future<User> getUser();
}

class UserService extends UserServiceInterface {
  final dio = DioClient.dio;

  @override
  Future<User> getUser() async {
    try {
      final response = await dio.get(
        '/user',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }

      return User.fromMap(response.data['data']);
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getUsers() async {
    try {
      final response = await dio.get(
        '/users',
      );

      return List.from(
        response.data['data'].map(
          (user) => User.fromMap(user),
        ),
      );
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String name,
    String? email,
    required String phone,
    File? photo,
  }) async {
    try {
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('name', name),
        MapEntry('phone', phone),
      ]);

      if (email != null) {
        formData.fields.add(MapEntry('email', email));
      }

      if (photo != null) {
        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              photo.path,
              filename: 'profile_photo.${photo.path.split('.').last}',
            ),
          ),
        );
      }

      await dio.post(
        "/profile/update",
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
