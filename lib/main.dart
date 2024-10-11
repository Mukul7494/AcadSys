import 'package:acadsys/shared/router.dart';
import 'package:acadsys/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'shared/firebase_options.dart';

const _title = 'SEMS';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: _title,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: true,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      themeMode: _themeMode,
      initialRoute: SEMSRoute.welcome.path,
      onGenerateRoute: SEMSRouter.generateSEMSRoute,
    );
  }
}
