import 'package:flutter/material.dart';

import 'student_app_bar.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: studentAppBar(),
      body: const Center(
        child: Text('Student Home'),
      ),
    );
  }
}
