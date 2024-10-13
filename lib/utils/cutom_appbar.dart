import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget {
  final String title;
  const MyCustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 50, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          const SizedBox(width: 70),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
