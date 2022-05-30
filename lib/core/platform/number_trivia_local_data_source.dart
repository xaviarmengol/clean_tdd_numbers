
import 'dart:convert';
import 'dart:math';

import 'package:clean_tdd_numbers/core/error/exception.dart';
import 'package:clean_tdd_numbers/core/platform/key_value_local_data_source.dart';
import 'package:clean_tdd_numbers/features/number_trivia/data/models/number_trivia_model.dart';


abstract class NumberTriviaLocalDataSource {

  NumberTriviaModel getConcreteNumberTrivia(double number);
  NumberTriviaModel getRandomCachedNumber();
  Future<void> cacheNumberTrivia (NumberTriviaModel triviaToCache);

}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {

  final KeyValueLocalDataSource keyValueLocalDataSource;
  NumberTriviaLocalDataSourceImpl({required this.keyValueLocalDataSource});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModelToCache) async {

    var numberString = triviaModelToCache.number.toString();
    var numberModelString = json.encode(triviaModelToCache.toJson());

    var savedOK = false;

    try {
      savedOK = await (keyValueLocalDataSource.setKeyValue(numberString, numberModelString));
    }
    catch (e) {
      print(e.toString());
      throw CacheException();
    }
    if (!savedOK) {
      print("Error catching value");
      throw CacheException();
    }

    return(Future.value());

  }

  @override
  NumberTriviaModel getConcreteNumberTrivia(double number) {

    var result = _getNumberTriviaModelFromLocalPrefs(number.toString());
    return (result);

  }

  NumberTriviaModel _getNumberTriviaModelFromLocalPrefs(String key) {
    NumberTriviaModel result;

    try {
      var keyValue = keyValueLocalDataSource.getKeyValue(key);

      var valueCoded = json.decode(keyValue.value);
      result = NumberTriviaModel.fromJson(valueCoded);

    } catch (e) {
      print(e.toString());
      throw CacheException();
    }

    return (result);
  }

  @override
  NumberTriviaModel getRandomCachedNumber() {
    final allKeysValues = keyValueLocalDataSource.getKeyValues().toList();
    final keyValueRandom = allKeysValues[Random().nextInt(allKeysValues.length)];

    print ("Random Key -> ${keyValueRandom.key}");
    return(getConcreteNumberTrivia(double.parse(keyValueRandom.key)));
  }



}