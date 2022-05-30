import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:clean_tdd_numbers/features/cache/domain/entities/key_value.dart';
import 'package:clean_tdd_numbers/features/cache/domain/repositories/key_value_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetKeyValuesUseCase extends UseCase<Set<KeyValue>, NoParams>{
  final KeyValueRepository repository;

  GetKeyValuesUseCase(this.repository);

  @override
  Future<Either<Failure, Set<KeyValue>>> call(NoParams params) async {
    return await repository.getKeyValues();
  }

}

