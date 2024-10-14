import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool? isNumeric;
  final bool? isMobile;
  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isNumeric = false,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $title';
          }
          if (isMobile! && value.length != 10) {
            return 'Please enter a valid mobile number';
          }

          return null;
        },
        controller: controller,
        inputFormatters: [
          if (isNumeric!) FilteringTextInputFormatter.digitsOnly,
          if (isMobile!) LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
