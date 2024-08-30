import 'package:flutter/material.dart';
import 'package:millima/features/groups/ui/screens/add_group_screen.dart';
import 'package:millima/features/rooms/ui/screens/rooms_screen.dart';
import 'package:millima/features/subject/ui/screens/subjects_screen.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';
import 'package:millima/features/users/ui/screens/profile_screen.dart';
import 'package:millima/features/users/ui/screens/show_users_screen.dart';

class CustomDrawerForAdmin extends StatelessWidget {
  const CustomDrawerForAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "MENU",
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AdminScreen();
                  },
                ),
                (route) => false,
              );
            },
            title: const Text(
              "Home Page",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ProfileScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Profile",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ShowUsersScreen(
                      roleId: 1,
                    );
                  },
                ),
              );
            },
            title: const Text(
              "Students",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ShowUsersScreen(
                      roleId: 2,
                    );
                  },
                ),
              );
            },
            title: const Text(
              "Teachers",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ShowUsersScreen(
                      roleId: 3,
                    );
                  },
                ),
              );
            },
            title: const Text(
              "Admins",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AddGroupScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Add Group",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const RoomScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Rooms",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const SubjectsScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Subjects",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
        ],
      ),
    );
  }
}
