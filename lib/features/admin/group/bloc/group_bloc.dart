import 'package:crm_system/data/models/group/group.dart';
import 'package:crm_system/data/services/group/group_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitialState()) {
    on<GetGroupsEvent>(_onGetGroups);
    on<GetStudentGroupsEvent>(_onGetStudentGroups);
    on<GetTeacherGroupsEvent>(_onGetTeacherGroups);
    on<AddGroupEvent>(_addGroups);
    on<UpdateGroupEvent>(_updateGroups);
    on<AddStudentsToGroupEvent>(_addStudentsToGroups);
    on<DeleteGroupEvent>(_deleteGroups);
  }

  Future<void> _onGetGroups(GetGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getGroups();
      List<Group> groups = [];
      print(response['data']);

      response['data'].forEach((value) {
        groups.add(Group.fromMap(value));
      });

      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      print(e);
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetStudentGroups(GetStudentGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getStudentGroups();
      List<Group> groups = [];

      response['data'].forEach((value) {
        groups.add(Group.fromMap(value));
      });

      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetTeacherGroups(GetTeacherGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getTeacherGroups();
      List<Group> groups = [];

      response['data'].forEach((value) {
        groups.add(Group.fromMap(value));
      });

      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addGroups(AddGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.addGroup(event.name, event.maintTeacherId,
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
    final GroupService groupService = GroupService();
    try {
      await groupService.updateGroup(event.groupId, event.name,
          event.mainTeacherId, event.assistantTeacherId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _deleteGroups(DeleteGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.deleteGroup(event.groupId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }
}
