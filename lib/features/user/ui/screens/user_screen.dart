import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/features.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the GetGroupsEvent when the screen initializes
    context.read<GroupBloc>().add(GetStudentGroups());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            size: 30,
          ),
        ),
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(LogoutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GroupErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is GroupLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                return GroupWidget(group: state.groups[index]);
              },
            );
          }
          return const Center(
            child: Text("No groups available!"),
          );
        },
      ),
    );
  }
}
