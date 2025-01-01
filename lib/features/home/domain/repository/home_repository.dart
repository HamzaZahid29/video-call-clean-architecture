import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entity/user.dart';
import '../../../../core/errors/failures.dart';

abstract class HomeRepository{
  Future<Either<Failure, List<User>>> loadHomeData();
}