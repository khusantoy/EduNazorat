import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/room/room_model.dart';
import 'package:millima/features/rooms/bloc/room_bloc.dart';
import 'package:millima/features/rooms/bloc/room_event.dart';
import 'package:millima/features/rooms/bloc/room_state.dart';
import 'package:millima/features/timetable/bloc/timetable_bloc.dart';
import 'package:millima/features/timetable/bloc/timetable_event.dart';
import 'package:millima/utils/helpers/extensions.dart';

class AddTimetableScreen extends StatefulWidget {
  const AddTimetableScreen({super.key, required this.groupId});

  final int groupId;

  @override
  State<AddTimetableScreen> createState() => _AddTimetableScreenState();
}

class _AddTimetableScreenState extends State<AddTimetableScreen> {
  int? selectedDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? selectedRoomId;

  bool isFormValid() {
    return selectedDay != null &&
        startTime != null &&
        endTime != null &&
        selectedRoomId != null;
  }

  bool isFormValidForRooms() {
    return selectedDay != null && startTime != null && endTime != null;
  }

  final List<Map<String, dynamic>> daysOfWeek = [
    {'day': 'Monday', 'value': 1},
    {'day': 'Tuesday', 'value': 2},
    {'day': 'Wednesday', 'value': 3},
    {'day': 'Thursday', 'value': 4},
    {'day': 'Friday', 'value': 5},
    {'day': 'Saturday', 'value': 6},
    {'day': 'Sunday', 'value': 7},
  ];

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? TimeOfDay.now() : startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Timetable"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Day of the Week:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade700))),
              isExpanded: true,
              value: selectedDay,
              hint: const Text("Choose a day"),
              items: daysOfWeek.map((day) {
                return DropdownMenuItem<int>(
                  value: day['value'],
                  child: Text(day['day']),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  selectedDay = newValue;
                });
              },
              style: const TextStyle(color: Colors.black, fontSize: 16),
              dropdownColor: Colors.blue.shade100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Start Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectTime(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              child: Text(
                startTime == null
                    ? "Choose Start Time"
                    : "Start Time: ${startTime!.format(context)}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select End Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectTime(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              child: Text(
                endTime == null
                    ? "Choose End Time"
                    : "End Time: ${endTime!.format(context)}",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isFormValidForRooms()) {
                    context.read<RoomBloc>().add(
                          GetAvailableRoomsEvent(
                            dayId: selectedDay!,
                            startTime: startTime!.formatTimeOfDay(),
                            endTime: endTime!.formatTimeOfDay(),
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Please fill all the fields."),
                        backgroundColor: Colors.red.shade600,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Show Available Rooms",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                if (state is RoomLoadingState) {
                  return Center(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }
                if (state is RoomErrorState) {
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                if (state is RoomLoadedState) {
                  final List<RoomModel> rooms = state.rooms;
                  if (rooms.isEmpty) {
                    return const Center(
                      child: Text("There are no available rooms :("),
                    );
                  } else {
                    return Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade700)),
                      child: ListView.builder(
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          final room = rooms[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRoomId = room.id;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 8, left: 8, right: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedRoomId == room.id
                                      ? Colors.green.shade700
                                      : Colors.blue.shade700,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Room name: ${room.name}",
                                    style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Capacity: ${room.capacity}",
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: isFormValid()
                    ? () {
                        Navigator.pop(context);
                        context.read<TimetableBloc>().add(CreateTimeTableEvent(
                            groupId: widget.groupId,
                            roomId: selectedRoomId!,
                            dayId: selectedDay!,
                            startTime: startTime!.format(context),
                            endTime: endTime!.format(context)));
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Add Timetable",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
