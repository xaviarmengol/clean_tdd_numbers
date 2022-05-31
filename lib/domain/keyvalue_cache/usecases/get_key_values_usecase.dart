import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/key_value.dart';
import '../repositories/key_value_repository.dart';

class GetKeyValuesUseCase extends UseCase<Set<KeyValue>, NoParams>{
  final KeyValueRepository _repository;

  GetKeyValuesUseCase(this._repository);

  @override
  Future<Either<Failure, Set<KeyValue>>> call(NoParams params)  {
    return Future.value(_repository.getKeyValues());
  }

}

