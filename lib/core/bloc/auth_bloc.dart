import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/role_selection_signin.dart';
import '../network/auth_services.dart';
import '../models/user_model.dart';
import 'user_bloc.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String role; // Add role to registration event
  const RegisterWithEmailAndPasswordEvent(this.email, this.password, this.role);

  @override
  List<Object?> get props => [email, password, role];
}

class SignOutEvent extends AuthEvent {}

// AuthState
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class RoleSelectedState extends AuthState {
  final UserRole role;
  RoleSelectedState(this.role);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// AuthBloc
class AuthBloc extends Cubit<AuthState> {
  final AuthServices _authServices;
  final UserBloc _userBloc;

  AuthBloc({required AuthServices authServices, required UserBloc userBloc})
      : _authServices = authServices,
        _userBloc = userBloc,
        super(AuthInitial()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    emit(AuthLoading());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        emit(AuthUnauthenticated());
        _userBloc.add(UserLoggedOut());
      } else {
        _fetchAndUpdateUserData(user.uid);
      }
    });
  }

  // Method to set the selected role
  void setSelectedRole(UserRole role) {
    emit(RoleSelectedState(role));
  }

  Future<void> _fetchAndUpdateUserData(String uid) async {
    try {
      final userDoc = await _authServices.getUsersCollection().doc(uid).get();
      if (userDoc.exists) {
        final userModel = UserModel.fromFirestore(userDoc);
        emit(AuthAuthenticated(userModel));

        // Add UserLoggedIn event to UserBloc
        _userBloc.add(UserLoggedIn(userModel));
      } else {
        emit(AuthError('User not found'));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
      emit(AuthError('Failed to fetch user data'));
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(AuthLoading());
      final userModel =
          await _authServices.signInWithEmailAndPassword(email, password);
      if (userModel != null) {
        emit(AuthAuthenticated(userModel));
        _userBloc.add(UserLoggedIn(userModel));
      }
    } catch (e) {
      emit(AuthError('Failed to sign in: ${e.toString()}'));
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      emit(AuthLoading());
      final userModel = await _authServices.signUpUserWithEmailAndPassword(
          email, password, role);
      if (userModel != null) {
        emit(AuthAuthenticated(userModel));
        _userBloc.add(UserLoggedIn(userModel));
      }
    } catch (e) {
      emit(AuthError('Failed to register: ${e.toString()}'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final user = await _authServices.signInWithGoogle();
      if (user != null) {
        await _fetchAndUpdateUserData(user.uid);
      }
    } catch (e) {
      emit(AuthError('Failed to sign in with Google: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _authServices.signOut();
      emit(AuthUnauthenticated());
      _userBloc.add(UserLoggedOut());
    } catch (e) {
      emit(AuthError('Failed to sign out: ${e.toString()}'));
    }
  }
}
