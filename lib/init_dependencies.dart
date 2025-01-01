import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'core/common/bloc/app_user/app_user_cubit.dart';
import 'core/common/bloc/password_visibility/password_visibility_cubit.dart';
import 'features/auth/data/datasources/auth_firebase_data_source.dart';
import 'features/auth/data/datasources/forget_password_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/repositories/forget_password_repository_implementation.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/repository/forget_password_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/forget_password.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_logout.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/auth/presentation/blocs/forget_password_bloc/forget_password_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initPasswordVisibilityCubit();
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseMessaging.instance);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(
      serviceLocator<FirebaseAuth>(),
      serviceLocator<FirebaseMessaging>()
    ),
  );
  serviceLocator.registerFactory<ForgetPasswordDataSource>(
    () => ForgetPasswordDataSourceImpl(
      serviceLocator<FirebaseAuth>(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator<AuthFirebaseDataSource>(),
    ),
  );
  serviceLocator.registerFactory<ForgetPasswordRepository>(
    () => ForgetPasswordRepositoryImplementation(
      serviceLocator<ForgetPasswordDataSource>(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => ForgetPassword(
      serviceLocator<ForgetPasswordRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogout(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userLogout: serviceLocator<UserLogout>(),
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        currentUser: serviceLocator<CurrentUser>(),
        appUserCubit: serviceLocator<AppUserCubit>()),
  );
  serviceLocator.registerLazySingleton(
    () => ForgetPasswordBloc(forgetPassword: serviceLocator<ForgetPassword>()),
  );
}

void _initPasswordVisibilityCubit() {
  serviceLocator.registerFactory<PasswordVisibilityCubit>(
    () => PasswordVisibilityCubit(),
  );
}
