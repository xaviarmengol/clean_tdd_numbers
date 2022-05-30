import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../cache/domain/usecases/clear_cache_usecase.dart';
import 'InputNumberPage_state.dart';



class PageNotifier extends StateNotifier<InputNumberPageState> {

  PageNotifier(this._clearCacheUseCase) : super(InputNumberPageState.initialValue);

  final ClearCacheUseCase _clearCacheUseCase;


  setRequestedValue(String newRequestedValue) {
    state = InputNumberPageState(requestedValue: newRequestedValue, snackBarText: '', internetConection: state.internetConection);
  }

  clearCache() async {
    final result = await _clearCacheUseCase(NoParams());
    result.fold(
            (failure) {state = InputNumberPageState(requestedValue: state.requestedValue, snackBarText: failure.reason, internetConection: state.internetConection);},
            (value) {state = InputNumberPageState(requestedValue: state.requestedValue, snackBarText: "Cache deleted", internetConection: state.internetConection);}
    );
    state = InputNumberPageState(requestedValue: state.requestedValue, snackBarText: '', internetConection: state.internetConection);
  }

}
