import 'package:flutter/material.dart';

import '../../core/constants/router.dart';
import '../../shared/theme/theme_toggle_button.dart';
import 'my_app_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        children: [
          Text('Welcome'),
          // ElevatedButton(onPressed: () => ),
        ],
      ),
      floatingActionButton: const ThemeToggleButton(),

    );
  }
}
