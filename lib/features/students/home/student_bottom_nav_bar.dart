import 'package:acadsys/core/constants/router.dart';
import 'package:acadsys/core/utils/snacbar_helper.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/theme_toggle_button.dart';
import '../../social/social.dart';
import '../classes/classes.dart';
import '../scanner/scanner.dart';
import '../student_bottom_bar.dart';
import '../student_drawer.dart';
import '../tests/test_results.dart';
import 'student_home.dart';

class StudentBottomNavBar extends StatefulWidget {
  const StudentBottomNavBar({super.key});

  @override
  _StudentBottomNavBarState createState() => _StudentBottomNavBarState();
}

class _StudentBottomNavBarState extends State<StudentBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    // Define a list of widgets for each route
    final List<Widget> screens = [
      const StudentHome(),
      const ClassesScreen(),
      const ScannerScreen(),
      const SocialScreen(),
      const TestsScreen(),
    ];
    // Define a list of icons for each tab
    final List<IconData> defaultIcons = [
      Icons.home,
      Icons.book,
      Icons.qr_code_scanner,
      Icons.people,
      Icons.assessment,
    ];

    final List<IconData> activeIcons = [
      Icons.home_filled,
      Icons.book_online,
      Icons.qr_code_rounded,
      Icons.people_alt,
      Icons.assessment_outlined,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEMS Student'),
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        actions: [
          IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).appBarTheme.backgroundColor),
                foregroundColor: WidgetStateProperty.all(
                    Theme.of(context).secondaryHeaderColor),
              ),
              onPressed: () => context.push(Routes.profile.path),
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 40,
              ))
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox(),
        ),
      ),
      drawer: const StudentDrawer(),
      body: BlocBuilder<StudentBottomBar, BottomNavItemS>(
        builder: (context, state) {
          // Use the state index to determine the active screen
          return screens[state.index];
        },
      ),
      bottomNavigationBar: BlocBuilder<StudentBottomBar, BottomNavItemS>(
        builder: (context, state) {
          return ConvexAppBar(
            curveSize: 5,
            style: TabStyle.fixedCircle,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            activeColor: Theme.of(context).secondaryHeaderColor,
            color: Theme.of(context).cardColor,
            items: List.generate(5, (index) {
              return TabItem(
                icon: state.index == index
                    ? activeIcons[index]
                    : defaultIcons[index],
                title: ['Home', 'Classes', 'Scanner', 'Social', 'Test'][index],
              );
            }),
            initialActiveIndex: 2,
            onTap: (index) {
              // Update the bloc state based on the tapped index
              context.read<StudentBottomBar>().updateIndex(index);
            },
          );
        },
      ),
    );
  }
}
