part of 'user_bloc.dart';

sealed class UserEvent {}

final class GetCurrentUserEvent extends UserEvent {}

final class GetStudentsEvent extends UserEvent {}

final class GetTeachersEvent extends UserEvent {}

final class GetAdminsEvent extends UserEvent {}
