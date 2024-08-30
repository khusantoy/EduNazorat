import 'package:flutter/material.dart';
import 'package:millima/data/models/models.dart';

class GroupInformationScreen extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInformationScreen({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          groupModel.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Teachers",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ListTile(
              title: Text(
                groupModel.mainTeacher.name,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(groupModel.mainTeacher.phone),
              leading: CircleAvatar(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  clipBehavior: Clip.hardEdge,
                  child: groupModel.mainTeacher.photo == null
                      ? const Icon(
                          Icons.person,
                          size: 40,
                        )
                      : Image.network("${groupModel.mainTeacher.photo}"),
                ),
              ),
            ),
            ListTile(
              title: Text(
                groupModel.assistantTeacher.name,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(groupModel.assistantTeacher.phone),
              leading: CircleAvatar(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  clipBehavior: Clip.hardEdge,
                  child: groupModel.assistantTeacher.photo == null
                      ? const Icon(
                          Icons.person,
                          size: 40,
                        )
                      : Image.network("${groupModel.assistantTeacher.photo}"),
                ),
              ),
            ),
            const Text(
              "Students",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            groupModel.students.isEmpty
                ? const Text("O'quvchilar mavjud emas")
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: groupModel.students.length,
                      itemBuilder: (context, index) {
                        final student = groupModel.students[index];
                        return ListTile(
                          title: Text(
                            student.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(student.phone),
                          leading: CircleAvatar(
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              clipBehavior: Clip.hardEdge,
                              child: student.photo == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 40,
                                    )
                                  : Image.network("${student.photo}"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
