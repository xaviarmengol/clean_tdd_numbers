
import 'package:clean_tdd_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';


abstract class NumberTriviaRepository {

  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(double? number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
  //Future<Either<Failure, bool>> clearCache();

}