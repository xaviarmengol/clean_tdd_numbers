

import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:clean_tdd_numbers/domain/number_trivia/usecases/get_all_cached_numbers_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/keyvalue_cache/usecases/clear_cache_usecase.dart';
import 'CachedValuesPage_state.dart';


class CachedValuesPageNotifier extends StateNotifier<CachedValuesPageState> {

  final GetAllCachedNumbersUseCase _getAllCachedNumbersUseCase;
  final ClearCacheUseCase _clearCacheUseCase;

  CachedValuesPageNotifier(this._getAllCachedNumbersUseCase, this._clearCacheUseCase) : super(CachedValuesPageState.initialValue);

  getCacheSet() async {
    final result = await _getAllCachedNumbersUseCase(NoParams());

    result.fold(
            (failure) {
              print("Error getting data cached");
              state = CachedValuesPageState.initialValue;
            },
            (value) {
              final valueToReturn = CachedValuesPageState(value.toList());
              print("value -> $valueToReturn");
              state = valueToReturn;
            });
    }

    deleteCache() async {
      final result = await _clearCacheUseCase(NoParams());

      result.fold(
              (failure) {
            print("Error deleting data cached");
          },
              (value) {
                state = CachedValuesPageState.initialValue;
          });
    }



}