// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/timetable/timetable_model.dart';
import 'package:millima/data/services/timetable/timetable_service.dart';
import 'package:millima/features/timetable/bloc/timetable_event.dart';
import 'package:millima/features/timetable/bloc/timetable_state.dart';

class TimetableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  TimetableBloc() : super(TimeTableInitialState()) {
    on<GetTimeTablesEvent>(_onGetTables);
    on<CreateTimeTableEvent>(_addTable);
  }

  Future<void> _onGetTables(GetTimeTablesEvent event, emit) async {
    emit(TimeTableLoadingState());
    final TimetableService timetableService = TimetableService();
    try {
      final Map<String, dynamic> response =
          await timetableService.getGroupTimeTables(event.groupId);

      print(response['data']);

      if (response['data'].isEmpty) {
        emit(TimeTableLoadedState(timeTables: null));
      } else {
        Timetable timeTable = Timetable.fromMap(response['data']);
        emit(TimeTableLoadedState(timeTables: timeTable));
      }
      print(response['data']);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }

  Future<void> _addTable(CreateTimeTableEvent event, emit) async {
    final TimetableService timetableService = TimetableService();
    try {
      await timetableService.createTimetable(event.groupId, event.roomId,
          event.dayId, event.startTime, event.endTime);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }
}
