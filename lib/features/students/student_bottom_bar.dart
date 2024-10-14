import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../shared/theme/theme_toggle_button.dart';

class StudentBottomBar extends StatelessWidget {
  const StudentBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Bottom Bar')),
      body: Center(
          child: TextButton(
        child: const Text('Click to show full example'),
        onPressed: () => Navigator.of(context).pushNamed('/bar'),
      )),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: const [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.note_add),
          TabItem(icon: Icons.qr_code_scanner),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.menu_book),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => debugPrint('click index=$i'),
      ),
      floatingActionButton: const ThemeToggleButton(),
    );
  }
}
