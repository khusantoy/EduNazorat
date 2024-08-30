part of 'subject_bloc.dart';

sealed class SubjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubjectInitialState extends SubjectState {}

class SubjectLoadingState extends SubjectState {}

class SubjectsLoadedState extends SubjectState {
  final List<SubjectModel> subjects;

  SubjectsLoadedState({required this.subjects});

  @override
  List<Object?> get props => [subjects];
}

class SubjectLoadedState extends SubjectState {
  final SubjectModel subject;

  SubjectLoadedState({required this.subject});

  @override
  List<Object?> get props => [subject];
}

class SubjectErrorState extends SubjectState {
  final String error;

  SubjectErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
