part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final User user;

  UserLoadedState({required this.user});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({required this.error});
}
