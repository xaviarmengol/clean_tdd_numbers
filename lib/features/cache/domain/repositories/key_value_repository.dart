
import 'package:clean_tdd_numbers/features/cache/domain/entities/key_value.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';


abstract class KeyValueRepository {

  Future<Either<Failure, Set<KeyValue>>> getKeyValues();
  Future<Either<Failure, KeyValue>> getKeyValue(String key);
  Future<Either<Failure, bool>> setKeyValue(String key, String value);
  Future<Either<Failure, bool>> clearCache();

}