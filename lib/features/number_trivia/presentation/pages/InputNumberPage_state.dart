import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputNumberPageState {
  final String requestedValue;

  const InputNumberPageState(this.requestedValue);
}

class PageNotifier extends StateNotifier<InputNumberPageState> {
  PageNotifier() : super(_initialValue);
  static const _initialValue = InputNumberPageState("0");

  void setRequestedValue(String newRequestedValue) {
    state = InputNumberPageState(newRequestedValue);
  }
}

final inputNumberPageProvider = StateNotifierProvider<PageNotifier, InputNumberPageState>(
      (ref) => PageNotifier(),
);




