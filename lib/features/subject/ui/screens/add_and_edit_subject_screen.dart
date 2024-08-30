import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';
class AddAndEditSubjectScreen extends StatefulWidget {
  const AddAndEditSubjectScreen({super.key, required this.subject});

  final SubjectModel? subject;

  @override
  State<AddAndEditSubjectScreen> createState() =>
      _AddAndEditSubjectScreenState();
}

class _AddAndEditSubjectScreenState extends State<AddAndEditSubjectScreen> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      setState(() {
        textController.text = widget.subject!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            widget.subject == null ? "Add Subject Screen" : "Edit Subject"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Subject Name",
            ),
          ),
          BlocConsumer<SubjectBloc, SubjectState>(listener: (context, state) {
            if (state is SubjectsLoadedState) {
              Navigator.pop(context);
            }
            if (state is SubjectErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          }, builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                context.read<SubjectBloc>().add(widget.subject == null
                    ? AddSubjectEvent(subjectName: textController.text)
                    : EditSubjectEvent(
                        subjectId: widget.subject!.id,
                        newName: textController.text));
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: state is SubjectLoadingState
                  ? const CircularProgressIndicator()
                  : Text(
                      widget.subject == null ? "Add Subject" : "Edit Subject"),
            );
          }),
        ],
      ),
    );
  }
}
