import 'package:flutter/material.dart';

import 'admin_app_bar.dart';

const text = 'Admin Home';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar(),
      body: const Center(
        child: Text(text),
      ),
    );
  }
}
