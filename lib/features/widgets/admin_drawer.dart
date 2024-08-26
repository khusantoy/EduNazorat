import 'package:crm_system/features/admin/student/views/student_screen.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DrawerHeader(
        child: Column(
          children: [
            const Text("Admin Panel"),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.people),
              title: const Text("O'qituvchilar"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentScreen(),
                  ),
                );
              },
              leading: const Icon(Icons.people),
              title: const Text("O'quvchilar"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text("Adminlar"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.manage_accounts),
              title: const Text("Guruhlarni boshqarish"),
            ),
          ],
        ),
      ),
    );
  }
}
