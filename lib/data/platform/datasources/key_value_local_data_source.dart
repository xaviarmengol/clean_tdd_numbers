
import 'package:clean_tdd_numbers/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/keyvalue_cache/entities/key_value.dart';



abstract class KeyValueLocalDataSource {

  Future<void> removeAllCache();
  KeyValue getKeyValue(String key);
  Set<KeyValue> getKeyValues();
  Future<bool> setKeyValue(String key, String value);

}

class KeyValueLocalDataSourceImpl implements KeyValueLocalDataSource {

  SharedPreferences sharedPreferences;
  KeyValueLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<void> removeAllCache() async {
    await sharedPreferences.clear();
    return(Future.value());
  }

  @override
  KeyValue getKeyValue(String key)  {

    KeyValue result;

    try {
      var value = sharedPreferences.getString(key);
      //print(sharedPrefRaw);
      if (value != null ) {
        result = KeyValue(key: key, value: value);
      }
      else {
        throw CacheException();
      }
    } catch (e) {
      print("Error Reading Cache. Key ${key} can not be read");
      print(e.toString());
      throw CacheException();
    }
    return (result);
  }

  @override
  Set<KeyValue> getKeyValues()  {
    var keyValues = <KeyValue>{};

    final keys = _getAllCachedKeys();
    for (var key in keys) {
      final keyValue = getKeyValue(key);
      keyValues.add(keyValue);
    }
    return (keyValues);
  }

  @override
  Future<bool> setKeyValue(String key, String value) async {
    var savedOK = false;

    try {
      savedOK = await (sharedPreferences.setString(key, value));
    }
    catch (e) {
      print(e.toString());
      throw CacheException();
    }

    if (!savedOK) {
      print("Error catching value");
      throw CacheException();
    }
    return savedOK;
  }


  Set<String> _getAllCachedKeys() {

    try {
      return(sharedPreferences.getKeys());
    } catch (e) {
      print(e.toString());
      throw CacheException();
    }

  }



}