import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, NoParams>> forgetPassword({
    required String email
  });
}