import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/bloc/app_user/app_user_cubit.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/auth/presentation/blocs/forget_password_bloc/forget_password_bloc.dart';
import 'firebase_options.dart';
import 'init_dependencies.dart';
import 'notification_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  serviceLocator.get<NotificationService>().initialize();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>()..add(AuthCurrentUser()),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ForgetPasswordBloc>(),
      ),
    ],
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {

  MyApp();

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<AppUserCubit>().updateUser(state.user);
          } else if (state is AuthFailure || state is AuthInitial) {
            context.read<AppUserCubit>().updateUser(null);
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Video Call Sample',
          theme: AppThemes.lightTheme,
          routerConfig: router,
        )
    );
  }
}

