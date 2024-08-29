part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class RoomInitialState extends RoomState {}

class RoomLoadingState extends RoomState {}

class RoomLoadedState extends RoomState {
  final List<Room> rooms;

  RoomLoadedState({required this.rooms});
}

class RoomErrorState extends RoomState {
  final String error;
  RoomErrorState({required this.error});
}
