import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entity/user.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_firebase_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return await _returnUser(() async => remoteDataSource
        .loginWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password,
      required String role}) async {
    return await _returnUser(() async => remoteDataSource
        .signUpWithEmailPassword(email: email, password: password, name: name, role: role));
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try{
        final user = await remoteDataSource.getCurrentUser();
        if(user == null){
          return left(Failure('User not logged in'));
        }else{
          return right(user);
        }
    }on ServerException catch (e){
      return left(Failure(e.toString()));
    }

  }
  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await remoteDataSource.logoutUser();
      return right(NoParams());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('An unexpected error occurred: $e'));
    }

  }

  Future<Either<Failure, User>> _returnUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on fire.FirebaseAuthException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
