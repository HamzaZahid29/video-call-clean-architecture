import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/bloc/app_user/app_user_cubit.dart';
import '../../../../../core/common/entity/user.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/current_user.dart';
import '../../../domain/usecases/user_login.dart';
import '../../../domain/usecases/user_logout.dart';
import '../../../domain/usecases/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserLogout _userLogout;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthlogin);
    on<AuthCurrentUser>(_onAuthCurrentUser);
    on<AuthLogoutUser>(_onAuthlogout);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
        role: event.role));
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthlogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthlogout(AuthLogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogout(NoParams());
    response.fold((l) => emit(AuthFailure(messege: l.message)), (user) {
      _appUserCubit.logoutUser();
      return emit(AuthLogoutSuccess());
    });
  }

  void _onAuthCurrentUser(
      AuthCurrentUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _currentUser(NoParams());
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}

// TODO:  test this properly
