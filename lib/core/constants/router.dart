import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login.dart';
import '../../features/auth/role_selection_Screen.dart';
import '../../features/onboarding/welcome.dart';
import '../bloc/auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

enum SEMSRoute {
  welcome,
  roleSelection,
  login,
  register,
  forgotPassword,
  resetPassword,
  profile,
  adminHome,
  adminProfile,
  teacherHome,
  teacherReport,
  teacherReportDetail,
  teacherAttendance,
  teacherAttendanceDetail,
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
      case SEMSRoute.roleSelection:
        return '/role-selection';
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
        return '/admin';
      case SEMSRoute.adminProfile:
        return '/admin/profile';
      case SEMSRoute.teacherHome:
        return '/teacher';
      case SEMSRoute.teacherReport:
        return '/teacher/report';
      case SEMSRoute.teacherReportDetail:
        return '/teacher/report/:id';
      case SEMSRoute.teacherAttendance:
        return '/teacher/attendance';
      case SEMSRoute.teacherAttendanceDetail:
        return '/teacher/attendance/:id';
      case SEMSRoute.studentHome:
        return '/student';
      case SEMSRoute.studentAttendance:
        return '/student/attendance';
      case SEMSRoute.studentAttendanceDetail:
        return '/student/attendance/:id';
      case SEMSRoute.studentReport:
        return '/student/report';
      case SEMSRoute.studentReportDetail:
        return '/student/report/:id';
    }
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final semsRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: SEMSRoute.welcome.path,
  routes: [
    GoRoute(
      path: SEMSRoute.welcome.path,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: SEMSRoute.roleSelection.path,
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: SEMSRoute.login.path,
      builder: (context, state) => const LoginScreen(),
    ),
    // Add other routes here as needed
  ],
  redirect: (context, state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    final authStatus = authState is AuthAuthenticated
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
    final userRole =
        authState is AuthAuthenticated ? authState.user.role : null;

    bool isAllowedPage =
        _isAllowedPage(state.uri.toString(), authStatus, userRole as UserRole?);

    if (authStatus == AuthStatus.unauthenticated && !isAllowedPage) {
      return SEMSRoute.login.path;
    }

    if (authStatus == AuthStatus.authenticated) {
      if (state.uri.toString() == SEMSRoute.login.path ||
          state.uri.toString() == SEMSRoute.register.path) {
        return _getHomePageForRole(userRole as UserRole?);
      }

      if (!isAllowedPage) {
        return _getHomePageForRole(userRole as UserRole?);
      }
    }

    return null;
  },
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
);

bool _isAllowedPage(String path, AuthStatus status, UserRole? role) {
  if (status == AuthStatus.unauthenticated) {
    return [
      SEMSRoute.welcome.path,
      SEMSRoute.login.path,
      SEMSRoute.register.path,
      SEMSRoute.forgotPassword.path,
      SEMSRoute.resetPassword.path,
      SEMSRoute.roleSelection.path,
    ].contains(path);
  }

  switch (role) {
    case UserRole.admin:
      return path.startsWith('/admin');
    case UserRole.teacher:
      return path.startsWith('/teacher');
    case UserRole.student:
      return path.startsWith('/student');
    case null:
      return false;
  }
}

String _getHomePageForRole(UserRole? role) {
  switch (role) {
    case UserRole.admin:
      return SEMSRoute.adminHome.path;
    case UserRole.teacher:
      return SEMSRoute.teacherHome.path;
    case UserRole.student:
      return SEMSRoute.studentHome.path;
    case null:
      return SEMSRoute.welcome.path;
  }
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text(error?.toString() ?? 'An unknown error occurred'),
      ),
    );
  }
}
