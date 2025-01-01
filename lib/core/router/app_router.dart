import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:videocallsample/core/router/static_app_routes.dart';
import '../../features/auth/presentation/pages/forget_password_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../common/bloc/app_user/app_user_cubit.dart';
import 'logging_navigator_observer.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [LoggingNavigatorObserver()],
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.loginScreen,
  routes: [
    GoRoute(
        name: Routes.loginScreen,
        path: Routes.loginScreen,
        pageBuilder: (context, state){
          final appUser = context.read<AppUserCubit>();
          return appUser.state is AppUserLoggedIn ? MaterialPage(child: LoginScreen()) :  MaterialPage(child: LoginScreen());
        }),
    GoRoute(
        name: Routes.signupScreen,
        path: Routes.signupScreen,
        pageBuilder: (context, state) => MaterialPage(child: SignUpScreen())),
    GoRoute(
        name: Routes.forgetPassword,
        path: Routes.forgetPassword,
        pageBuilder: (context, state) =>
            MaterialPage(child: ForgetPasswordScreen())),
  ],
);
