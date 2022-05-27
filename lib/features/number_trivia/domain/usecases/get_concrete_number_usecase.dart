import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberUseCase extends UseCase<NumberTrivia, Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberUseCase(this.repository);

  @override
  Future <Either<Failure, NumberTrivia>> call(Params params)
  async {
    return await repository.getConcreteNumberTrivia(params.number);
  }

}

class Params extends Equatable {
  final int number;
  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}

