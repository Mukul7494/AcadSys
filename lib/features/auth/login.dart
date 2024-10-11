import 'package:flutter/material.dart';

import 'auth_app_bar.dart';

const text = 'Login';

class LoginScreen extends StatelessWidget {
  
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      appBar: authAppBar(),
      body: Form(
        key: _formKey,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

}
