import 'package:acadsys/features/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/auth_bloc.dart';

enum UserRole { admin, student, teacher }

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Role')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _navigateToSignup(context, UserRole.admin),
              child: const Text('Admin'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _navigateToSignup(context, UserRole.student),
              child: const Text('Student'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _navigateToSignup(context, UserRole.teacher),
              child: const Text('Teacher'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSignup(BuildContext context, UserRole role) {
    // Access the AuthBloc using BlocProvider.of
    final authBloc = BlocProvider.of<AuthBloc>(context);

    // Call a method in AuthBloc to set the selected role
    authBloc.setSelectedRole(role); 

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(role: role), 
      ),
    );
  }
}
