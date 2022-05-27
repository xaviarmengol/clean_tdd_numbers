import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberUseCase extends UseCase<NumberTrivia, NoParams>{
  final NumberTriviaRepository repository;

  GetRandomNumberUseCase(this.repository);

  @override
  Future <Either<Failure, NumberTrivia>> call(NoParams params)
  async {
    final repoAnswer = await repository.getRandomNumberTrivia();
    print("GetRandomNumberUseCase: {$repoAnswer}");
    return repoAnswer;
  }

}

