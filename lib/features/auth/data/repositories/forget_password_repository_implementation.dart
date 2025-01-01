import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repository/forget_password_repository.dart';
import '../datasources/forget_password_data_source.dart';

class ForgetPasswordRepositoryImplementation implements ForgetPasswordRepository {
  final ForgetPasswordDataSource forgetPasswordDataSource;

  ForgetPasswordRepositoryImplementation(this.forgetPasswordDataSource);

  @override
  Future<Either<Failure, NoParams>> forgetPassword({required String email}) async {
    try {
      await forgetPasswordDataSource.sendResetPasswordLink(email: email);
      return right(NoParams());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('An unexpected error occurred: $e'));
    }
  }
}
