import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:clean_tdd_numbers/features/cache/domain/repositories/key_value_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

class SetKeyValuesUseCase extends UseCase<bool, Params>{
  final KeyValueRepository repository;

  SetKeyValuesUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.setKeyValue(params.key, params.value);
  }

}

class Params extends Equatable {
  final String key;
  final String value;
  const Params({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];
}

