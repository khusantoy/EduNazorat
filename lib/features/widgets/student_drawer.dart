import 'package:flutter/material.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: DrawerHeader(
        child: Column(
          children: [
            Text("Student Panel"),
          ],
        ),
      ),
    );
  }
}
