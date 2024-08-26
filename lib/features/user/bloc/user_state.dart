part of 'user_bloc.dart';

class UserState extends Equatable {
  final User? user;
  final List<User>? students;
  final List<User>? teachers;
  final List<User>? admins;
  final bool isLoading;
  final String? error;
  const UserState({
    this.user,
    this.students,
    this.teachers,
    this.admins,
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    User? user,
    List<User>? students,
    List<User>? teachers,
    List<User>? admins,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      students: students ?? this.students,
      teachers: teachers ?? this.teachers,
      admins: admins ?? this.admins,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, error];
}
