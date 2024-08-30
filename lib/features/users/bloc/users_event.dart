part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUsersEvent extends UsersEvent {}

class UpdateUsersEvent extends UsersEvent {
  final String name;
  final String phone;
  final String? email;
  final File? phote;

  UpdateUsersEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.phote,
  });
}
