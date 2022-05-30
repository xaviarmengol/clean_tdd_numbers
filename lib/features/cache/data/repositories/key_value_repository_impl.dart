
import 'package:clean_tdd_numbers/core/error/failures.dart';
import 'package:clean_tdd_numbers/core/platform/key_value_local_data_source.dart';
import 'package:clean_tdd_numbers/features/cache/domain/entities/key_value.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/key_value_repository.dart';


//typedef ReturnFutureModelFun = Future<NumberTriviaModel> Function();

class KeyValueRepositoryImp implements KeyValueRepository {

  final KeyValueLocalDataSource keyvalueDataSource;

  KeyValueRepositoryImp({
    required this.keyvalueDataSource,
  });


  @override
  Future<Either<Failure, bool>> clearCache() async {

    try {
      await keyvalueDataSource.removeAllCache();
      return Right(true);
    } catch (e) {
      print("Error clearing cache");
      return Left(CacheDeleteFailure());
    }
  }

  @override
  Future<Either<Failure, KeyValue>> getKeyValue(String key) async {

    try {
      final keyValue = await keyvalueDataSource.getKeyValue(key);
      return Right(keyValue);
    } catch (e) {
      print("Error getting key value");
      return Left(CacheFailure());
    }

  }

  @override
  Future<Either<Failure, Set<KeyValue>>> getKeyValues() async {
    try {
      final keyValues = await keyvalueDataSource.getKeyValues();
      return Right(keyValues);
    } catch (e) {
      print("Error getting set of key values");
      return Left(CacheFailure());
    }
  }


  @override
  Future<Either<Failure, bool>> setKeyValue(String key, String value) async {
    try {
      await keyvalueDataSource.setKeyValue(key, value);
      return Right(true);
    } catch (e) {
      print("Error setting key value");
      return Left(CacheFailure());
    }
  }


}


