import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';
import '../network/auth_services.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final String userId;

  const LoadUser(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  const UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UserLoggedIn extends UserEvent {
  final UserModel user;

  const UserLoggedIn(this.user);

  @override
  List<Object?> get props => [user];
}

class UserLoggedOut extends UserEvent {}

// States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthServices _authServices;

  UserBloc(this._authServices) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await _authServices.fetchUserData(event.userId);
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(const UserError('User not found'));
      }
    } catch (e) {
      emit(UserError('Failed to load user: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _authServices.updateUserData(event.user);
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError('Failed to update user: ${e.toString()}'));
    }
  }

  void _onUserLoggedIn(UserLoggedIn event, Emitter<UserState> emit) {
    emit(UserLoaded(event.user)); // Update UserBloc state
  }

  void _onUserLoggedOut(UserLoggedOut event, Emitter<UserState> emit) {
    emit(UserInitial());
  }

  void logout() {
    add(UserLoggedOut());
  }

  // String? getCurrentUserRole() {
  //   if (state is UserLoaded) {
  //     return (state as UserLoaded).role;
  //   }
  //   return null;
  // }
}
