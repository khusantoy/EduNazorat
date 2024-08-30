// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';
import 'package:millima/features/user/ui/widgets/custom_drawer_for_admin.dart';

class AddStudentToGroupScreen extends StatefulWidget {
  final GroupModel groupModel;
  const AddStudentToGroupScreen({super.key, required this.groupModel});

  @override
  State<AddStudentToGroupScreen> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddStudentToGroupScreen> {
  TextEditingController studentsIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Student To Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: const CustomDrawerForAdmin(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              controller: studentsIdController,
              decoration: InputDecoration(
                  labelText: "Students Id(1,2,6)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  List students = [];
                  for (var element in widget.groupModel.students) {
                    students.add(element.id);
                  }
                  students.addAll(studentsIdController.text
                      .split(",")
                      .map(int.parse)
                      .toList());
                  print(students);
                  context.read<GroupBloc>().add(AddStudentsToGroupEvent(
                      groupId: widget.groupModel.id, studentsId: students));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: const Text(
                  "Add Group",
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
