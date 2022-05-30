class InputNumberPageState {

  final String requestedValue;
  final bool internetConection;
  final String snackBarText;

  const InputNumberPageState({required this.requestedValue, required this.snackBarText, required this.internetConection});

  @override
  String toString() {
    return "$requestedValue - $snackBarText - $internetConection";
  }

  static const initialValue = InputNumberPageState(requestedValue: '0', snackBarText: '', internetConection: false);
}



