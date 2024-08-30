import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/data/services/services.dart';
part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectService _subjectService;

  SubjectBloc({required SubjectService subjectService})
      : _subjectService = subjectService,
        super(SubjectInitialState()) {
    on<GetSubjectsEvent>(_onGetSubjects);
    on<GetOneSubjectEvent>(_onGetOneSubject);
    on<AddSubjectEvent>(_onAddSubject);
    on<EditSubjectEvent>(_onEditSubject);
    on<DeleteSubjectEvent>(_onDeleteSubject);
  }

  Future<void> _onGetSubjects(
      GetSubjectsEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoadingState());
    try {
      final subjects = await _subjectService.getSubjects();
      emit(SubjectsLoadedState(subjects: subjects));
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetOneSubject(
      GetOneSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoadingState());
    try {
      final subject = await _subjectService.getOneSubject(event.subjectId);
      emit(SubjectLoadedState(subject: subject));
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _onAddSubject(
      AddSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoadingState());
    try {
      await _subjectService.addSubject(event.subjectName);
      add(GetSubjectsEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _onEditSubject(
      EditSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoadingState());
    try {
      await _subjectService.editSubject(event.subjectId, event.newName);
      add(GetSubjectsEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _onDeleteSubject(
      DeleteSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoadingState());
    try {
      await _subjectService.deleteSubject(event.subjectId);
      add(GetSubjectsEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }
}
