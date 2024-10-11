import 'package:flutter/material.dart';

import 'auth_app_bar.dart';

const text = 'Register';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
