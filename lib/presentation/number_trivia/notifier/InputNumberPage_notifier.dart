import 'package:clean_tdd_numbers/domain/network_info/usecases/get_connection_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/keyvalue_cache/usecases/clear_cache_usecase.dart';
import 'InputNumberPage_state.dart';


class InputNumberPageNotifier extends StateNotifier<InputNumberPageState> {

  InputNumberPageNotifier(this._clearCacheUseCase, this._getConnectionStatusUseCase) : super(InputNumberPageState.initialValue);

  final ClearCacheUseCase _clearCacheUseCase;
  final GetConnectionStatusUseCase _getConnectionStatusUseCase;


  setRequestedValue(String newRequestedValue) {
    state = InputNumberPageState(requestedValue: newRequestedValue, snackBarText: '', hasInternetConnection: state.hasInternetConnection);
  }

  clearCache() async {
    final result = await _clearCacheUseCase(NoParams());
    result.fold(
            (failure) {state = InputNumberPageState(requestedValue: state.requestedValue, snackBarText: failure.reason, hasInternetConnection: state.hasInternetConnection);},
            (value) {state = InputNumberPageState(requestedValue: state.requestedValue, snackBarText: "Cache deleted", hasInternetConnection: state.hasInternetConnection);}
    );
    state = InputNumberPageState(requestedValue: state.requestedValue, snackBarText: '', hasInternetConnection: state.hasInternetConnection);
  }

  Stream<bool> onConnectionStatusChange() {
    final onConnectionChange = _getConnectionStatusUseCase.onStatusChange();

    onConnectionChange.listen((status) {
        if (status && !state.hasInternetConnection) {
          state = InputNumberPageState(
              requestedValue: state.requestedValue,
              snackBarText: "Ethernet Connection is ready",
              hasInternetConnection: true);
        }
        else if (!status && state.hasInternetConnection) {
          state = InputNumberPageState(
              requestedValue: state.requestedValue,
              snackBarText: "Connection Lost",
              hasInternetConnection: false);
        }

        state = InputNumberPageState(
            requestedValue: state.requestedValue,
            snackBarText: "",
            hasInternetConnection: state.hasInternetConnection
        );

    });

    return onConnectionChange;
  }

}
