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
            if (context != null) {
              Navigator.pushNamed(context, Routes.studentList.path);
            } else {
              debugPrint('Error: Context is null in admin_drawer');
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Teachers'),
          onTap: () {
            if (context != null) {
              Navigator.pushNamed(context, Routes.teacherList.path);
            } else {
              debugPrint('Error: Context is null in admin_drawer');
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            if (context != null) {
              Navigator.pop(context);
            } else {
              debugPrint('Error: Context is null in admin_drawer');
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            if (context != null) {
              SnackbarHelper.showInfoSnackBar(context, 'Not implemented yet');
            } else {
              debugPrint('Error: Context is null in admin_drawer');
            }
          },
        ),
      ],
    ),
  );
}
