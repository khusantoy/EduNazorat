import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/room/room_model.dart';
import 'package:millima/features/rooms/bloc/room_bloc.dart';
import 'package:millima/features/rooms/bloc/room_event.dart';
import 'package:millima/features/rooms/ui/screens/rooms_screen.dart';

class ManageRoom extends StatefulWidget {
  final RoomModel? roomModel;
  const ManageRoom({super.key, required this.roomModel});

  @override
  State<ManageRoom> createState() => _ManageRoomState();
}

class _ManageRoomState extends State<ManageRoom> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController descriptionEditingController =
      TextEditingController();

  final TextEditingController capacityEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.roomModel != null) {
      nameEditingController.text = widget.roomModel!.name;
      descriptionEditingController.text = widget.roomModel!.description;
      capacityEditingController.text = widget.roomModel!.capacity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.roomModel == null ? "Add Room" : "Edit Room",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descriptionEditingController,
              decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: capacityEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "capacity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  context.read<RoomBloc>().add(AddRoomEvent(
                      name: nameEditingController.text,
                      description: descriptionEditingController.text,
                      capacity: int.parse(capacityEditingController.text)));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: const Text(
                  "Add Room",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}