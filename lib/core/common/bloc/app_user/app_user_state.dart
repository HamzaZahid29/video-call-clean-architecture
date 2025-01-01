  part of 'app_user_cubit.dart';

  @immutable
  sealed class AppUserState {}

  final class AppUserInitial extends AppUserState {}
  final class AppUserLoggedIn extends AppUserState {
    User user;

    AppUserLoggedIn(this.user);
  }
