
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/platform/key_value_local_data_source.dart';
import '../data/repositories/key_value_repository_impl.dart';
import '../domain/usecases/clear_cache_usecase.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});


final keyValueLocalDataSourceProvider = Provider ((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return KeyValueLocalDataSourceImpl(sharedPreferences:sharedPreferences);
});

final keyValueLocalDataSourceRepositoryProvider = Provider ((ref) {

  final keyValueLocalDataSource = ref.watch(keyValueLocalDataSourceProvider);
  return KeyValueRepositoryImp(keyvalueDataSource: keyValueLocalDataSource);

});


final clearCacheUseCaseProvider = Provider ((ref)  {
  final repository =  ref.watch(keyValueLocalDataSourceRepositoryProvider);
  return ClearCacheUseCase(repository);
});