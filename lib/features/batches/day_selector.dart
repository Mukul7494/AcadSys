import 'package:flutter/material.dart';

class SelectDayCard extends StatelessWidget {
  final String day;
  const SelectDayCard({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // (5),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          day,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
