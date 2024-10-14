import 'package:acadsys/utils/switch_button.dart';
import 'package:flutter/material.dart';

class AttendanceStudentCard extends StatelessWidget {
  const AttendanceStudentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 158, 158, 158),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Chota Bheem',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(47, 33, 149, 243),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(64, 158, 158, 158),
                width: 1,
              ),
            ),
            child: const Text('1'),
          ),

          const SizedBox(
            width: 5,
          ),

          const SwitchButton()
          // const Text('Present'),
        ],
      ),
    );
  }
}
