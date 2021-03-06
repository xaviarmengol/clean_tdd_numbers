import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/key_value_repository.dart';

class ClearCacheUseCase extends UseCase<bool, NoParams>{
  final KeyValueRepository repository;

  ClearCacheUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearCache();
  }


}

