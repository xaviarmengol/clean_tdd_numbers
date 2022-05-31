class InputNumberPageState {

  final String requestedValue;
  final bool hasInternetConnection;
  final String snackBarText;

  const InputNumberPageState({required this.requestedValue, required this.snackBarText, required this.hasInternetConnection});

  @override
  String toString() {
    return "$requestedValue - $snackBarText - $hasInternetConnection";
  }

  static const initialValue = InputNumberPageState(requestedValue: '0', snackBarText: '', hasInternetConnection: false);
}



