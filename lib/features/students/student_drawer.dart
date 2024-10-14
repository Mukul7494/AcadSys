import 'package:acadsys/core/constants/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Student Info'),
          ),
          ListTile(
            title: const Text('Attendence'),
            onTap: () => context.go(Routes.attendance.path),
          ),
          const Divider(),
          ListTile(
            title: const Text('Courses'),
            onTap: () => context.go(Routes.courses.path),
          ),
        ],
      ),
    );
  }
}
