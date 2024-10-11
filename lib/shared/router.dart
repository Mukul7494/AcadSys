import 'package:flutter/material.dart';
import '../features/auth/login.dart';
import '../features/auth/register.dart';
import '../features/onboarding/welcome.dart';

enum SEMSRoute {
  // onboarding
  welcome,

  // auth
  login,
  register,
  forgotPassword,
  resetPassword,
  profile,

  // admin
  adminHome,
  adminProfile,

  // teacher
  teacherHome,
  teacherReport,
  teacherReportDetail,
  teacherAttendance,
  teacherAttendanceDetail,

  // student
  studentHome,
  studentAttendance,
  studentAttendanceDetail,
  studentReport,
  studentReportDetail,
}

extension SEMSRouteExtension on SEMSRoute {
  String get path {
    switch (this) {
      case SEMSRoute.welcome:
        return '/';
      case SEMSRoute.login:
        return '/login';
      case SEMSRoute.register:
        return '/register';
      case SEMSRoute.forgotPassword:
        return '/forgot-password';
      case SEMSRoute.resetPassword:
        return '/reset-password';
      case SEMSRoute.profile:
        return '/profile';
      case SEMSRoute.adminHome:
        return '/admin-home';
      case SEMSRoute.adminProfile:
        return '/admin-profile';
      case SEMSRoute.teacherHome:
        return '/teacher-home';
      case SEMSRoute.teacherReport:
        return '/teacher-report';
      case SEMSRoute.teacherReportDetail:
        return '/teacher-report-detail';
      case SEMSRoute.teacherAttendance:
        return '/teacher-attendance';
      case SEMSRoute.teacherAttendanceDetail:
        return '/teacher-attendance-detail';
      case SEMSRoute.studentHome:
        return '/student-home';
      case SEMSRoute.studentAttendance:
        return '/student-attendance';
      case SEMSRoute.studentAttendanceDetail:
        return '/student-attendance-detail';
      case SEMSRoute.studentReport:
        return '/student-report';
      case SEMSRoute.studentReportDetail:
        return '/student-report-detail';
    }
  }
}

class SEMSRouter {
  static MaterialPageRoute generateSEMSRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      // case '/forgot-password':
      //   return UnimplementedError();

      // case '/reset-password':
      //   return UnimplementedError();

      // case '/profile':
      //   return UnimplementedError();
      // case '/admin-home':
      //   return UnimplementedError();

      // case '/admin-profile':
      //   return UnimplementedError();

      // case '/teacher-home':
      //   return UnimplementedError();

      // case '/teacher-report':
      //   return UnimplementedError();

      // case '/teacher-report-detail':
      //   return UnimplementedError();

      // case '/teacher-attendance':
      //   return UnimplementedError();

      // case '/teacher-attendance-detail':
      //   return UnimplementedError();

      // case '/student-home':
      //   return UnimplementedError();

      // case '/student-attendance':
      //   return UnimplementedError();

      // case '/student-attendance-detail':
      //   return UnimplementedError();

      // case '/student-report':
      //   return UnimplementedError();

      // case '/student-report-detail':
      //   return UnimplementedError();

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static void semsNavigateTo(BuildContext context, SEMSRoute route) {
    Navigator.pushNamed(context, route.path);
  }
}
