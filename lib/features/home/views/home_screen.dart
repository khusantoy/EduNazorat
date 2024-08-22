import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user/bloc/user_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogoutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Text(
              state.user?.name ?? 'Unknown',
              style: const TextStyle(fontSize: 50),
            ),
          );
        },
      ),
    );
  }
}
