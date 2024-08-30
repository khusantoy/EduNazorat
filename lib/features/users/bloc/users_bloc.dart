import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/data/services/services.dart';
import 'package:millima/utils/di/locator.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitialState()) {
    on<GetUsersEvent>(_onGetUsers);
  }

  Future<void> _onGetUsers(GetUsersEvent event, emit) async {
    emit(UsersLoadingState());
    final userService = getIt.get<UserService>();
    try {
      final users = await userService.getUsers();
      emit(UsersLoadedState(users: users));
    } catch (e) {
      emit(UsersErrorState(error: e.toString()));
    }
  }
}
