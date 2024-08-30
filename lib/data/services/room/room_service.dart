// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:millima/utils/network/dio_client.dart';

class RoomService {
  final dio = DioClient.dio;

  Future<void> addRoom(String name, String description, int capacity) async {
    try {
      final data = {
        "name": name,
        "description": description,
        "capacity": capacity,
      };

      await dio.post(
        '/rooms',
        data: data,
      );
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRooms() async {
    try {
      final response = await dio.get(
        '/rooms',
      );
      return response.data;
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAvailableRooms(
    int dayId,
    String startTime,
    String endTime,
  ) async {
    try {
      final response = await dio.get(
        '/available-rooms',
        queryParameters: {
          "day_id": dayId,
          "start_time": startTime,
          "end_time": endTime,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRoom(
      int roomId, String name, String description, int capacity) async {
    try {
      await dio.put(
        '/rooms/$roomId',
        data: {
          'name': name,
          'description': description,
          'capacity': capacity,
        },
      );
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRoom(int roomId) async {
    try {
      await dio.delete('/rooms/$roomId');
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
