import 'package:acadsys/core/constants/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/bloc/auth_bloc.dart';
import '../../core/utils/snacbar_helper.dart';
import 'role_selection_signin.dart';

class RegisterScreen extends StatefulWidget {
  final UserRole role;
  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idController = TextEditingController();
  final _departmentController = TextEditingController();
  String _selectedGender = 'male';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.role.toString().split('.').last.capitalize()} Signup'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
          } else if (state is AuthAuthenticated) {
            _showSuccessDialog();
          } else if (state is AuthError) {
            SnackbarHelper.showErrorSnackBar(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(_nameController, 'Name'),
                _buildTextField(_emailController, 'Email'),
                _buildTextField(_passwordController, 'Password',
                    isPassword: true),
                if (widget.role == UserRole.student ||
                    widget.role == UserRole.teacher)
                  _buildTextField(_idController,
                      '${widget.role.toString().split('.').last.capitalize()} ID'),
                if (widget.role == UserRole.student ||
                    widget.role == UserRole.teacher)
                  _buildGenderField(),
                if (widget.role == UserRole.teacher)
                  _buildTextField(_departmentController, 'Department'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        obscureText: isPassword,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your $label' : null,
      ),
    );
  }

  Widget _buildGenderField() {
    return Row(
      children: [
        const Text('Gender:'),
        Radio<String>(
          value: 'male',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        const Text('Male'),
        Radio<String>(
          value: 'female',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        const Text('Female'),
      ],
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().registerWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
          widget.role.toString().split('.').last);   
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signup Successful'),
          content: const SizedBox(
            height: 100,
            child: Center(
              child: Icon(Icons.check_circle, size: 50, color: Colors.green),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.pop();
                context.go(Routes.login.path);
              },
            ),
          ],
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
