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
      child: DrawerHeader(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
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
                "Bosh sahifa",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
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
                "Profil",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
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
                "O'quvchilar",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
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
                "O'qituvchilar",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
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
                "Adminlar",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group_add),
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
                "Gurux qo'shish",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.meeting_room_rounded),
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
                "Xonalar",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.subject),
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
                "Fanlar",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
