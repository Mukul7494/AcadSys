import 'package:flutter/material.dart';

import 'auth_app_bar.dart';

const text = 'Login';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(),
      body: const Center(
        child: Text(text),
      ),
    );
  }
}
