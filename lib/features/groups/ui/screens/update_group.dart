import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';

class UpdateGroup extends StatefulWidget {
  final GroupModel group;
  const UpdateGroup({super.key, required this.group});

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();

  TeacherDropDown? mainTeacher;
  TeacherDropDown? assistantTeacher;
  SubjectDropForGroup? subjectDropForGroup;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current group values
    nameEditingController.text = widget.group.name;

    // Initialize dropdowns with current teacher IDs
    mainTeacher = TeacherDropDown(
      label: "Select Main Teacher",
      selectedId: widget.group.mainTeacher.id,
    );
    assistantTeacher = TeacherDropDown(
      label: "Select Assistant Teacher",
      selectedId: widget.group.assistantTeacher.id,
    );

    subjectDropForGroup = SubjectDropForGroup(
      selectedId: widget.group.subject?.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupLoadedState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Group",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextFormField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos guruh nomini kiriting";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                mainTeacher!,
                const SizedBox(height: 15),
                assistantTeacher!,
                const SizedBox(height: 15),
                subjectDropForGroup!,
                const SizedBox(height: 15),
                BlocBuilder<GroupBloc, GroupState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state is GroupLoadingState) {
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          // Handle the update group event
                          context.read<GroupBloc>().add(
                                UpdateGroupEvent(
                                  groupId: widget.group.id,
                                  name: nameEditingController.text,
                                  mainTeacherId: mainTeacher!.selectedId!,
                                  assistantTeacherId:
                                      assistantTeacher!.selectedId!,
                                  subjectId: subjectDropForGroup!.id,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                      child: state is GroupLoadingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Update Group",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
