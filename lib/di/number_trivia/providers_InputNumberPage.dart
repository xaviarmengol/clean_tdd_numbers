
import 'package:clean_tdd_numbers/di/network_info/providers_network_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/number_trivia/notifier/InputNumberPage_notifier.dart';
import '../../presentation/number_trivia/notifier/InputNumberPage_state.dart';
import '../keyvalue_cache/providers_cache.dart';

final inputNumberPageNotifierProvider = StateNotifierProvider<InputNumberPageNotifier, InputNumberPageState>((ref) {

  final clearCacheUseCase = ref.watch(clearCacheUseCaseProvider);
  final getConnectionStatusUseCase = ref.watch(getConnectionUseCaseProvider);

  return InputNumberPageNotifier(clearCacheUseCase, getConnectionStatusUseCase);

  },);
