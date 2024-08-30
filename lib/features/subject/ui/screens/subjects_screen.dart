import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/features.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
        centerTitle: true,
      ),
      drawer: const CustomDrawerForAdmin(),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        bloc: context.read<SubjectBloc>()..add(GetSubjectsEvent()),
        builder: (context, state) {
          if (state is SubjectLoadingState) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
          if (state is SubjectErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          }
          if (state is SubjectsLoadedState) {
            final subjects = state.subjects;
            if (subjects.isEmpty) {
              return Center(
                child: Text(
                  "There are no subjects yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.indigo,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            subjects[index].name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddAndEditSubjectScreen(
                                              subject: subjects[index],
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<SubjectBloc>().add(
                                    DeleteSubjectEvent(
                                        subjectId: subjects[index].id));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text("Ma'lumotlar topilmadi"),
          );
        },
      ),
      floatingActionButton: TextButton.icon(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.blue.shade700,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const AddAndEditSubjectScreen(subject: null)));
        },
        label: const Text(
          "Add Subject",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
