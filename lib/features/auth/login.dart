import 'package:flutter/material.dart';
import '../../core/constants/router.dart';
import '../../core/utils/snacbar_helper.dart';
import '../../shared/theme/theme_toggle_button.dart';
import 'auth_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome back to SEMS!👋',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 10),
              _buildPasswordField(),
              _buildForgotPasswordButton(),
              const SizedBox(height: 10),
              _buildLoginButton(),
              const SizedBox(height: 16),
              _buildGoogleSignInButton(),
              const SizedBox(height: 16),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: const ThemeToggleButton(),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please enter your email' : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please enter your password' : null,
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () =>
            SnackbarHelper.showInfoSnackBar(context, 'Not implemented yet'),
        child: const Text('Forgot password?'),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      onPressed: _isLoading ? null : () {},
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Login', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildGoogleSignInButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : () {},
      child: const Text('Sign in with Google'),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: _isLoading
          ? null
          : () {},
      child: const Text('Don\'t have an account? Register'),
    );
  }
}
