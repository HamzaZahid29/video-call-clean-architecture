import 'package:fpdart/src/either.dart';

import 'package:videocallsample/core/common/entity/user.dart';

import 'package:videocallsample/core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository{
  HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<Either<Failure, List<User>>> loadHomeData()async {
    try {
      final data = await homeDataSource.fetchHomeData();
      return right(data);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('An unexpected error occurred: $e'));
    }
  }

}