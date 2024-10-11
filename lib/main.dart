import 'package:acadsys/core/constants/router.dart';
import 'package:acadsys/shared/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc/theme_bloc.dart';
import 'core/network/firebase_options.dart';

const _title = 'SEMS';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: _title,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: _title,
          debugShowCheckedModeBanner: true,
          theme: lightThemeData(),
          darkTheme: darkThemeData(),
          themeMode: state.themeMode,
          initialRoute: SEMSRoute.welcome.path,
          onGenerateRoute: SEMSRouter.generateSEMSRoute,
          builder: (context, child) {
            return BlocListener<ThemeBloc, ThemeState>(
              listener: (context, state) {
                if (state.themeMode == ThemeMode.system) {
                  final brightness = MediaQuery.of(context).platformBrightness;
                  BlocProvider.of<ThemeBloc>(context)
                      .add(SystemThemeChangedEvent(brightness));
                }
              },
              child: child!,
            );
          },
        );
      },
    );
  }
}
