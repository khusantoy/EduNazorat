part of 'subject_bloc.dart';

sealed class SubjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubjectsEvent extends SubjectEvent {}

class GetOneSubjectEvent extends SubjectEvent {
  final String subjectId;

  GetOneSubjectEvent({required this.subjectId});

  @override
  List<Object?> get props => [subjectId];
}

class AddSubjectEvent extends SubjectEvent {
  final String subjectName;

  AddSubjectEvent({required this.subjectName});

  @override
  List<Object?> get props => [subjectName];
}

class EditSubjectEvent extends SubjectEvent {
  final int subjectId;
  final String newName;

  EditSubjectEvent({required this.subjectId, required this.newName});

  @override
  List<Object?> get props => [subjectId, newName];
}

class DeleteSubjectEvent extends SubjectEvent {
  final int subjectId;

  DeleteSubjectEvent({required this.subjectId});

  @override
  List<Object?> get props => [subjectId];
}
