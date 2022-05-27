
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

extension EitherExt on Either {
  Future<Either<Failure, dynamic>> bindAsync (Function asyncF) async {
    return await (fold(
            (failure) => Left(failure),
            (rightValue) async {
          return await asyncF(rightValue);
        })
    );
  }


  Either<Failure, dynamic> ifRightDo (Function fun) {
    return fold(
            (failure) => Left(failure),
            (rightValue) {
          fun(rightValue);
          return Right(rightValue);
        }
    );
  }

  Either<Failure, dynamic> ifLeftDo (Function fun) {
    return fold(
            (failure) {
          fun(failure);
          return Left(failure);
        },
            (rightValue) => Right(rightValue)
    );
  }

}
