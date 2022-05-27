
import 'dart:convert';

import 'package:clean_tdd_numbers/core/error/exception.dart';
import 'package:clean_tdd_numbers/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class NumberTriviaLocalDataSource {

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.

  Future<NumberTriviaModel> getLastNumber();
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<void> cacheNumberTrivia (NumberTriviaModel triviaToCache);

}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {

  SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  static String lastValueKey = 'LAST_NUMBER';

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModelToCache) async {

    var numberString = triviaModelToCache.number.toString();
    var numberModelString = json.encode(triviaModelToCache.toJson());

    var savedOK = false;
    var savedOKLast = false;

    try {
      savedOK = await (sharedPreferences.setString(
          numberString, numberModelString));

      savedOKLast = await (sharedPreferences.setString(
          lastValueKey, numberModelString));
    }
    catch (e) {
      print(e.toString());
      throw CacheException();
    }
    if (!savedOK || !savedOKLast) {
      print("Error catching value");
      throw CacheException();
    }

    return(Future.value());

  }

  @override
  Future<NumberTriviaModel> getLastNumber() {
    var result = _getNumberTriviaModelFromLocalPrefs(lastValueKey);
    //print("NumberTriviaLocalDataSourceImpl -> getLastNumber: {$result}");
    return(Future.value(result));
  }

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {

    var result = _getNumberTriviaModelFromLocalPrefs(number.toString());
    return(Future.value(result));

  }

  NumberTriviaModel _getNumberTriviaModelFromLocalPrefs(String value) {
    NumberTriviaModel result;

    try {
      var sharedPrefRaw = sharedPreferences.getString(value);
      //print(sharedPrefRaw);
      if (sharedPrefRaw != null ) {
        var decoded = json.decode(sharedPrefRaw);
        result = NumberTriviaModel.fromJson(decoded);
        //print("NumberTriviaLocalDataSourceImpl -> _getNumberTriviaModelFromLocalPrefs: {$result}");
      }
      else {
        print("Error Reading Cache. sharedPrefRaw is null");
        throw CacheException();
      }
    } catch (e) {
      print(e.toString());
      throw CacheException();
    }

    return (result);
  }


}