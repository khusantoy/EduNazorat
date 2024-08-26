import 'package:crm_system/data/models/user/user.dart';
import 'package:crm_system/data/services/user/user_service.dart';

class UserRepository {
  final UserServiceInterface _userService;

  UserRepository({
    required UserServiceInterface userService,
  }) : _userService = userService;

  Future<User> getUser() async {
    return await _userService.getUser();
  }

  Future<List<User>> getStudents() async {
    return await _userService.getStudents();
  }

  Future<List<User>> getTeachers() async {
    return await _userService.getTeachers();
  }

  Future<List<User>> getAdmins() async {
    return await _userService.getAdmins();
  }
}
