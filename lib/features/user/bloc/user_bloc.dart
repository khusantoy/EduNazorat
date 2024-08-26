import 'package:crm_system/data/models/user/user.dart';
import 'package:crm_system/domain/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<GetStudentsEvent>(_onGetStudents);
    on<GetTeachersEvent>(_onGetTeachers);
    on<GetAdminsEvent>(_onGetAdmins);
  }

  void _onGetCurrentUser(GetCurrentUserEvent event, emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final user = await _userRepository.getUser();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onGetStudents(GetStudentsEvent event, emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final students = await _userRepository.getStudents();
      emit(state.copyWith(students: students, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onGetTeachers(GetTeachersEvent event, emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final teachers = await _userRepository.getTeachers();
      emit(state.copyWith(teachers: teachers, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onGetAdmins(GetAdminsEvent event, emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final admins = await _userRepository.getAdmins();
      emit(state.copyWith(admins: admins, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
