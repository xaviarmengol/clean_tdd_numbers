import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class InputConverter {

  Either<Failure, double> stringToPositiveDouble (String numberStr) {

    return stringToDouble(numberStr).bind(checkIsPositive).bind(checkNotExponential);

  }

  Either<Failure, double> stringToDouble (String numberStr) {
    try {
      var result = double.parse(numberStr);
      return Right(result);
    } catch (e) {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, double> checkIsPositive (double number) {

    if(number<0) return Left(InvalidInputFailure());
    return Right(number);
  }

  Either<Failure, double> checkNotExponential (double number) {
    final numberString = number.toStringAsFixed(0);
    if (numberString.contains('e')) return Left(InvalidInputFailure());
    return Right(number);
  }


}