// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/data/model/group_model.dart';
import 'package:vazifa/data/services/group_service.dart';

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
      List<GroupModel> groups = [];
      print(response['data']);
      print("++++++++++++++++++++++++++++++++++");

      response['data'].forEach((value) {
        groups.add(GroupModel.fromMap(value));
      });

      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      print(e);
      print("-------------");
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetStudentGroups(GetStudentGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getStudentGroups();
      List<GroupModel> groups = [];

      response['data'].forEach((value) {
        groups.add(GroupModel.fromMap(value));
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
      List<GroupModel> groups = [];

      response['data'].forEach((value) {
        groups.add(GroupModel.fromMap(value));
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
