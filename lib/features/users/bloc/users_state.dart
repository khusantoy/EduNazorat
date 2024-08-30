part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<User> users;

  UsersLoadedState({required this.users});
}

class UsersErrorState extends UsersState {
  final String error;
  UsersErrorState({required this.error});
}
