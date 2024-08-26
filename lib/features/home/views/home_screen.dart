import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:crm_system/features/widgets/admin_drawer.dart';
import 'package:crm_system/features/widgets/student_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../user/bloc/user_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/images/search.svg"),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/images/notifications.svg"),
              ),
              PopupMenuButton(
                icon: const Icon(
                  CupertinoIcons.person_crop_circle,
                  size: 25,
                ),
                onSelected: (value) {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "logout",
                      child: Text("Logout"),
                    ),
                  ];
                },
              ),
            ],
          ),
          drawer: state.user!.role.id == 3
              ? const AdminDrawer()
              : const StudentDrawer(),
          body: const SizedBox(),
        );
      },
    );
  }
}
