
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cache/di/providers_cache.dart';
import '../presentation/notifier/InputNumberPage_notifier.dart';
import '../presentation/notifier/InputNumberPage_state.dart';

final inputNumberPageProvider = StateNotifierProvider<PageNotifier, InputNumberPageState>((ref) {

  final clearCacheUseCase = ref.watch(clearCacheUseCaseProvider);

  return PageNotifier(clearCacheUseCase);

  },);
