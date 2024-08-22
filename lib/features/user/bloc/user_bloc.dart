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
}
