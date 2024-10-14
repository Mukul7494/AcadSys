
import 'package:flutter/material.dart';
import 'admin_app_bar.dart';
import 'admin_drawer.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar(),
      drawer: adminDrawer(context),
      body: const Center(
        child: Text('This is Admin Home'),
      ),

    );

  }
}
