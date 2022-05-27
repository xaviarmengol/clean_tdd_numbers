import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class InputConverter {

  Either<Failure, int> stringToUnsignedInt (String numberStr) {

    return stringToInt(numberStr).bind(checkIsPositive);

  }

  Either<Failure, int> stringToInt (String numberStr) {
    try {
      var result = int.parse(numberStr);
      return Right(result);
    } catch (e) {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, int> checkIsPositive (int number) {

    if(number<0) return Left(InvalidInputFailure());
    return Right(number);
  }


}