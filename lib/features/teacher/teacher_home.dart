import 'package:flutter/material.dart';

import 'teacher_app_bar.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(),
      body: const Center(
        child: Text('Teacher Home'),
      ),
    );
  }
}
