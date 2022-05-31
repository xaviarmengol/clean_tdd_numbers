
import 'package:clean_tdd_numbers/di/number_trivia/providers_number_trivia.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/number_trivia/notifier/CachedValuesPage_notifier.dart';
import '../../presentation/number_trivia/notifier/CachedValuesPage_state.dart';
import '../keyvalue_cache/providers_cache.dart';

final cachedValuesPageNotifierProvider = StateNotifierProvider<CachedValuesPageNotifier, CachedValuesPageState>((ref) {

  final getAllCachedNumbersUseCase = ref.watch(getAllCachedUseCaseProvider);
  final clearCacheUseCase = ref.watch(clearCacheUseCaseProvider);

  return CachedValuesPageNotifier(getAllCachedNumbersUseCase, clearCacheUseCase);

  },);
