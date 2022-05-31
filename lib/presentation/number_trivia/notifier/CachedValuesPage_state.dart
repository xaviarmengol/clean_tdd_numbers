
import 'package:clean_tdd_numbers/domain/number_trivia/entities/number_trivia.dart';

class CachedValuesPageState {
  final List<NumberTrivia> cachedNumberTrivias;

  CachedValuesPageState(this.cachedNumberTrivias);

  static final initialValue = CachedValuesPageState(<NumberTrivia>[]);
}