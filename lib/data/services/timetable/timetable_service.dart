// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:millima/utils/network/dio_client.dart';

class TimetableService {
  final dio = DioClient.dio;

  Future<void> createTimetable(
    int groupId,
    int roomId,
    int dayId,
    String startTime,
    String endTime,
  ) async {
    try {
      final data = {
        "group_id": groupId,
        "room_id": roomId,
        "day_id": dayId,
        "start_time": startTime,
        "end_time": endTime
      };

      await dio.post(
        '/group-classes',
        data: data,
      );
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroupTimeTables(int groupId) async {
    try {
      final response = await dio.get(
        '/group-timetable/$groupId',
      );

      return response.data;
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
