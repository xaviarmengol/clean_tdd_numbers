import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetAllCachedNumbersUseCase extends UseCase<Set<NumberTrivia>, NoParams>{
  final NumberTriviaRepository repository;

  GetAllCachedNumbersUseCase(this.repository);

  @override
  Future<Either<Failure, Set<NumberTrivia>>> call(NoParams params)
   {
    final repoAnswer = repository.getAllCachedNumbers();
    return Future.value(repoAnswer);
  }

}

