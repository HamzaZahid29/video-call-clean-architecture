import 'package:fpdart/fpdart.dart';
import 'package:videocallsample/core/common/entity/user.dart';
import 'package:videocallsample/core/usecase/usecase.dart';
import 'package:videocallsample/features/home/domain/repository/home_repository.dart';

import '../../../../core/errors/failures.dart';

class GetHomeData implements UseCase<List<User>, NoParams>{
  HomeRepository homeRepository;

  GetHomeData({required this.homeRepository});

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await homeRepository.loadHomeData();
  }
}