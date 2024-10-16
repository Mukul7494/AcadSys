import 'package:acadsys/core/utils/snacbar_helper.dart';
import 'package:flutter/material.dart';
import '../../core/constants/router.dart';

Drawer adminDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Admin Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Students'),
          onTap: () {
            Navigator.pushNamed(context, Routes.studentList.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Teachers'),
          onTap: () {
            Navigator.pushNamed(context, Routes.teacherList.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            SnackbarHelper.showInfoSnackBar(context, 'Not implemented yet');
          },
        ),
      ],
    ),
  );
}
