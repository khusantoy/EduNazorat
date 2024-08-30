import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/data/services/group/group_service.dart';
part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitialState()) {
    on<GetGroupsEvent>(_onGetGroups);
    on<AddGroupEvent>(_addGroups);
    on<UpdateGroupEvent>(_updateGroups);
    on<AddStudentsToGroupEvent>(_addStudentsToGroups);
    on<GetStudentGroups>(getStudentGroups);
    on<GetTeacherGroups>(getTeacherGroups);
  }

  Future<void> _onGetGroups(GetGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getGroups();
      List<GroupModel> groups = [];

      response['data'].forEach(
        (value) {
          groups.add(
            GroupModel.fromJson(value),
          );
        },
      );
      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addGroups(AddGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.addGroup(event.name, event.mainTeacherId,
          event.assistantTeacherId, event.subjectId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addStudentsToGroups(AddStudentsToGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.addStudentsToGroup(event.groupId, event.studentsId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _updateGroups(UpdateGroupEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      await groupService.updateGroup(
        event.groupId,
        event.name,
        event.mainTeacherId,
        event.assistantTeacherId,
        event.subjectId,
      );
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> getStudentGroups(GetStudentGroups event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();

    try {
      List<GroupModel> groups = await groupService.getStudentGroups();
      emit(GroupLoadedState(groups: groups));
    } catch (error) {
      emit(GroupErrorState(error: error.toString()));
    }
  }

  Future<void> getTeacherGroups(GetTeacherGroups event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();

    try {
      List<GroupModel> groups = await groupService.getTeacherGroups();
      emit(GroupLoadedState(groups: groups));
    } catch (error) {
      emit(GroupErrorState(error: error.toString()));
    }
  }
}
