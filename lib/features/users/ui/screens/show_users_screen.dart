import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';

class ShowUsersScreen extends StatefulWidget {
  final int roleId;
  const ShowUsersScreen({super.key, required this.roleId});

  @override
  State<ShowUsersScreen> createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawerForAdmin(),
      appBar: AppBar(
        title: Text(
          widget.roleId == 1
              ? "Students"
              : widget.roleId == 2
                  ? "Teachers"
                  : "Admins",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UsersErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UsersLoadedState) {
          List<User> roleFilteredUsers = [];
          for (var element in state.users) {
            if (element.roleId == widget.roleId) {
              roleFilteredUsers.add(element);
            }
          }
          return ListView.builder(
            itemCount: roleFilteredUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  roleFilteredUsers[index].name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(roleFilteredUsers[index].phone),
                leading: CircleAvatar(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    clipBehavior: Clip.hardEdge,
                    child: roleFilteredUsers[index].photo == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                          )
                        : Image.network("${roleFilteredUsers[index].photo}"),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
