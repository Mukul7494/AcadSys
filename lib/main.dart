import 'package:acadsys/features/students/student_bottom_bar.dart';
import 'package:acadsys/shared/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/bloc/auth_bloc.dart';
import 'core/bloc/theme_bloc.dart';
import 'core/bloc/user_bloc.dart';
import 'core/constants/router.dart';
import 'core/network/auth_services.dart';
import 'core/network/firebase_options.dart';

const _title = 'SEMS';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   
    options: DefaultFirebaseOptions.web,
  );
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(AuthServices()),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          authServices: AuthServices(),
          userBloc: BlocProvider.of<UserBloc>(context),
        ),
      ),
      BlocProvider<StudentBottomBar>(create: (context) => StudentBottomBar()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final semsRouter = AppRouter(context);
        return MaterialApp.router(
          title: _title,
          debugShowCheckedModeBanner: true,
          theme: SEMSTheme.lightThemeData(),
          darkTheme: SEMSTheme.darkThemeData(),
          themeMode: state.themeMode,
          routerConfig: semsRouter.router,
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

