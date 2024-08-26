import 'package:crm_system/features/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetTeachersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("O'qituvchilar"),
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return ListView.builder(
          itemCount: state.teachers!.length,
          itemBuilder: (context, index) {
            final student = state.students![index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(student.photo == ''
                    ? "https://i.pinimg.com/736x/dc/9c/61/dc9c614e3007080a5aff36aebb949474.jpg"
                    : student.photo!),
              ),
              title: Text(student.name),
              subtitle: Text(student.phone),
            );
          },
        );
      }),
    );
  }
}
