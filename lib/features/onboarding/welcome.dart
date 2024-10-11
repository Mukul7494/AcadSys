import 'package:acadsys/core/constants/router.dart';
import 'package:flutter/material.dart';
import '../../shared/theme/theme_toggle_button.dart';
import 'my_app_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome'),
            ElevatedButton(
              onPressed: () =>
                  SEMSRouter.semsNavigateTo(context, SEMSRoute.login),
              child: const Text(
                'Get Started 🏌️',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const ThemeToggleButton(),

    );
  }
}
