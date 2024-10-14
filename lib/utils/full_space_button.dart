import 'package:flutter/material.dart';

class FullSpaceButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FullSpaceButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 50,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
