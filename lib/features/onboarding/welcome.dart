import 'package:flutter/material.dart';

import 'my_app_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: const Center(
        child: Text('Welcome'),
      ),
    );
  }
}
