import 'package:fpdart/src/either.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/forget_password_repository.dart';

class ForgetPassword implements UseCase<NoParams, ForgetPasswordParams> {
  final ForgetPasswordRepository forgetPasswordRepository;

  ForgetPassword(this.forgetPasswordRepository);

  @override
  Future<Either<Failure, NoParams>> call(ForgetPasswordParams params) async {
    return await forgetPasswordRepository.forgetPassword(email: params.email);
  }
}

class ForgetPasswordParams {
  final String email;

  ForgetPasswordParams({required this.email});
}
