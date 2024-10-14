import 'dart:async';
import 'package:acadsys/features/students/profile.dart';
import 'package:acadsys/features/teachers/teachers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:acadsys/features/onboarding/welcome.dart';
import 'package:acadsys/features/auth/login.dart';
import 'package:acadsys/features/auth/register.dart';
import '../../features/admin/admin_home.dart';
import '../../features/attendance/attendance_page.dart';
import '../../features/auth/role_selection_signin.dart';
import '../../features/courses/add_courses_page.dart';
import '../../features/social/social.dart';
import '../../features/students/classes/classes.dart';
import '../../features/students/home/student_bottom_nav_bar.dart';
import '../../features/students/scanner/scanner.dart';
import '../../features/students/student_list.dart';
import '../../features/students/tests/test_results.dart';
import '../../features/teachers/teacher_home.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/user_bloc.dart';

// Routes names
enum Routes {
  welcome,
  roleSelection,
  login,
  register,
  profile,
  home,
  adminHome,
  teacherHome,
 
  teacherList, 
  studentHome,
  studentList,
  attendance,
  courses,
  classes,
  scanner,
  social,
  test,
  notFound

}

// Routes paths
extension RouteExtension on Routes {
  String get path {
    switch (this) {
      case Routes.welcome:
        return '/welcome';
      case Routes.roleSelection:
        return '/role-selection';
      case Routes.login:
        return '/login';
      case Routes.register:
        return '/register';
      case Routes.home:
        return '/home';
      case Routes.adminHome:
        return '/admin-home';
      
      case Routes.studentHome:
        return '/student-home';
      case Routes.studentList:
        return '/student-list';
      case Routes.classes:
        return '/classes';
      case Routes.scanner:
        return '/scanner';
      case Routes.social:
        return '/social';
      case Routes.test:
        return '/test';
      case Routes.profile:
        return '/profile';

      case Routes.teacherHome:
        return '/teacher-home';
      case Routes.teacherList:
        return '/teacher-list';
      case Routes.attendance:
        return '/attendance';
      case Routes.courses:
        return '/courses';
      case Routes.notFound:
        return '/404';
      default:
        return '/';

     
    }
  }
}
class AppRouter {
  final BuildContext context;

  AppRouter(this.context);

GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    initialLocation: Routes.welcome.path,
    routes: [
      GoRoute(
        path: Routes.welcome.path,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.roleSelection.path,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: Routes.profile.path,
        builder: (context, state) => const MyProfile(),
      ),
      GoRoute(
        path: Routes.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register.path,
        builder: (context, state) {
          final role = state.extra as UserRole?;
          return RegisterScreen(role: role ?? UserRole.student);
        },
      ),
      GoRoute(
        path: Routes.adminHome.path,
        builder: (context, state) => const AdminHome(),
      ),
      GoRoute(
        path: Routes.studentHome.path,
        builder: (context, state) => const StudentBottomNavBar(),
      ),
      GoRoute(
        path: Routes.studentList.path,
        builder: (context, state) => const StudentList(),
      ),
      GoRoute(
          path: Routes.classes.path,
          builder: (context, state) => const ClassesScreen()),
      GoRoute(
          path: Routes.scanner.path,
          builder: (context, state) => const ScannerScreen()),
      GoRoute(
          path: Routes.social.path,
          builder: (context, state) => const SocialScreen()),
      GoRoute(
          path: Routes.test.path,
          builder: (context, state) => const TestsScreen()),
      
      GoRoute(
        path: Routes.teacherHome.path,
        builder: (context, state) => const TeacherHome(),
      ),
      GoRoute(
        path: Routes.teacherList.path,
        builder: (context, state) => const TeacherList(),
      ),
      GoRoute(
        path: Routes.teacherList.path,
        builder: (context, state) => const TeacherList(),
      ),
      GoRoute(
        path: Routes.attendance.path,
        builder: (context, state) => const AttendancePage(),
      ),
      GoRoute(
        path: Routes.courses.path,
        builder: (context, state) => const AddCoursesPage(),
      ),
      // GoRoute(
      //   path: Routes.notFound.path,
      //   builder: (context, state) => const NotFoundScreen(),
      // ),
    ],
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>().state;
      final userBloc = context.read<UserBloc>().state;
      final authState = authBloc;
      final userState = userBloc;
      final isLoggingIn = state.uri.toString() == Routes.welcome.path;

      if (authState is AuthLoading) {
        if (userState is UserLoaded) {
          switch (userState.user.role) {
            case 'Admin':
              return Routes.adminHome.path;
            case 'Teacher':
              return Routes.teacherHome.path;
            case 'Student':
              return Routes.studentHome.path;
            default:
              return Routes.login.path;
          }
        }
      }
      if (authState is AuthUnauthenticated) {
        if (!isLoggingIn) {
          if (userState is UserLoaded) {
            switch (userState.user.role) {
              case 'Admin':
                return Routes.adminHome.path;
              case 'Teacher':
                return Routes.teacherHome.path;
              case 'Student':
                return Routes.studentHome.path;
              default:
                return Routes.login.path;
            }
          }
        }
      }
      if (authState is AuthAuthenticated) {
        if (isLoggingIn) {
          if (userState is UserLoaded) {
            switch (userState.user.role) {
              case 'Admin':
                return Routes.adminHome.path;
              case 'Teacher':
                return Routes.teacherHome.path;
              case 'Student':
                return Routes.studentHome.path;
              
              default:
                return Routes.login.path;
            }
          }
        }
      }
      // If no redirects apply, return null to allow the navigation
      return null;
    
    },
    refreshListenable: GoRouterRefreshStream(
      context.read<AuthBloc>().stream,
    ),
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );
}


class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// Helper function to get the home path based on user role
String _getHomePathForRole(String role) {
  switch (role) {
    case 'Admin':
      return Routes.adminHome.path;
    case 'Teacher':
      return Routes.teacherHome.path;
    case 'Student':
      return Routes.studentHome.path;
    default:
      return Routes.login.path;
  }
}
