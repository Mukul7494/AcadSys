import 'dart:async';

import 'package:acadsys/core/constants/router.dart';
import 'package:acadsys/features/auth/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../core/utils/error_handler.dart';
import '../../core/utils/snacbar_helper.dart';
import '../../shared/theme/theme_toggle_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(Future<void> Function() signInMethod) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await signInMethod().timeout(const Duration(seconds: 30));
        await _checkUserRoleAndNavigate();
      } on FirebaseAuthException catch (e) {
        SnackbarHelper.showErrorSnackBar(
            context, ErrorHandler.getErrorMessage(e));
      } on TimeoutException {
        SnackbarHelper.showErrorSnackBar(
            context, 'Login attempt timed out. Please try again.');
      } catch (e) {
        SnackbarHelper.showErrorSnackBar(
            context, 'An unexpected error occurred. Please try again.');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithEmailAndPassword() =>
      _signIn(() => FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          ));

  Future<void> _signInWithGoogle() => _signIn(() async {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      });

  Future<void> _cacheUserData(User user, String role) async {
    final box = Hive.box('userBox');
    await box.put('userId', user.uid);
    await box.put('userEmail', user.email);
    await box.put('userRole', role);
  }

  Future<void> _checkUserRoleAndNavigate() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final String userRole = userDoc['role'];
          await _cacheUserData(user, userRole);

          switch (userRole) {
            case 'Admin':
              Navigator.pushReplacementNamed(context, SEMSRoute.adminHome.path);
              break;
            case 'Teacher':
              Navigator.pushReplacementNamed(
                  context, SEMSRoute.teacherHome.path);
              break;
            case 'Student':
              Navigator.pushReplacementNamed(
                  context, SEMSRoute.studentHome.path);
              break;
            default:
              SnackbarHelper.showErrorSnackBar(context, 'Unknown user role');
          }
        } else {
          SnackbarHelper.showErrorSnackBar(context, 'User document not found');
        }
      } catch (e) {
        SnackbarHelper.showErrorSnackBar(
            context, 'Error fetching user role: $e');
      }
    }
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
              const Text(
                'Welcome back to SEMS!👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter your password'
                    : null,
              ),
              _buildForgotPasswordButton(),
              const SizedBox(height: 10),
              _buildLoginButton(),
              const SizedBox(height: 16),
              _buildGoogleSignInButton(),
              const SizedBox(height: 16),
              _buildFacebookSignInButton(),
              const SizedBox(height: 16),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: const ThemeToggleButton(),
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
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: _isLoading ? null : _signInWithEmailAndPassword,
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Login', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildGoogleSignInButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signInWithGoogle,
      child: const Text('Sign in with Google'),
    );
  }

  Widget _buildFacebookSignInButton() {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () =>
              SnackbarHelper.showInfoSnackBar(context, 'Not implemented yet'),
      child: const Text('Sign in with Facebook'),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: _isLoading
          ? null
          : () => Navigator.pushReplacementNamed(
              context, SEMSRoute.roleSelection.path),
      child: const Text('Don\'t have an account? Register'),
    );
  }
}
