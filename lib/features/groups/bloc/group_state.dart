part of 'group_bloc.dart';

sealed class GroupState extends Equatable {
  @override
  List<Object> get props => [];
}

class GroupInitialState extends GroupState {}

class GroupLoadingState extends GroupState {}

class GroupLoadedState extends GroupState {
  final List<GroupModel> groups;

  GroupLoadedState({required this.groups});
}

class GroupErrorState extends GroupState {
  final String error;
  GroupErrorState({required this.error});
}
