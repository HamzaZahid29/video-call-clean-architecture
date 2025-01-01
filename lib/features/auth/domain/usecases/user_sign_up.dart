import 'package:fpdart/src/either.dart';

import '../../../../core/common/entity/user.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams>{
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override

  Future<Either<Failure, User>> call(UserSignUpParams params) async{
    return await authRepository.signUpWithEmailPassword(name: params.name, email: params.email, password: params.password);
  }
}
class UserSignUpParams{
  final String email;
  final String password;
  final String name;

  UserSignUpParams({required this.email,required this.password, required this.name,});

}