
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/key_value.dart';


abstract class KeyValueRepository {

  Either<Failure, Set<KeyValue>> getKeyValues();
  Either<Failure, KeyValue> getKeyValue(String key);
  Future<Either<Failure, bool>> setKeyValue(String key, String value);
  Future<Either<Failure, bool>> clearCache();

}