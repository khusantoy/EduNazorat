// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/features.dart';

class SubjectDropForGroup extends StatefulWidget {
  SubjectDropForGroup({super.key, this.selectedId});

  int? selectedId;
  int get id => selectedId!;

  @override
  State<SubjectDropForGroup> createState() => _SubjectDropForGroupState();
}

class _SubjectDropForGroupState extends State<SubjectDropForGroup> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
    context.read<SubjectBloc>().add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
      buildWhen: (previous, current) => current is UsersLoadedState,
      builder: (context, state) {
        if (state is SubjectsLoadedState) {
          final subjects = state.subjects;

          return DropdownButtonFormField<int>(
            value: widget.selectedId,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Choose Subject",
            ),
            items: [
              for (var subject in subjects)
                DropdownMenuItem(
                  value: subject.id,
                  child: Text(subject.name),
                ),
            ],
            validator: (value) {
              if (value == null) {
                return "Iltimos fan tanlang";
              }

              return null;
            },
            onChanged: (value) {
              setState(() {
                widget.selectedId = value;
              });
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
