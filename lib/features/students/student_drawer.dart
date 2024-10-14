import 'package:flutter/material.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Student Info'),
          ),
          ListTile(
            title: Text('Shedule'),
          ),
          ListTile(
            title: Text('Exam Calaender'),
          ),
        ],
      ),
    );
  }
}
