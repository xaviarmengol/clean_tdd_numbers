import 'package:clean_tdd_numbers/core/util/either_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_usecase.dart';
import '../../domain/usecases/get_random_number_usecase.dart';
import '../bloc/number_trivia_bloc.dart';
import 'number_trivia_state.dart';

class NumberNotifier extends StateNotifier<NumberTriviaState> {
  final GetConcreteNumberUseCase _getConcreteNumberUseCase;
  final GetRandomNumberUseCase _getRandomNumberUseCase;
  final InputConverter _inputConverter;

  NumberNotifier(this._getConcreteNumberUseCase, this._getRandomNumberUseCase,
      this._inputConverter)
      : super(Empty());

  getConcreteTrivia(String numberText) async {
    var result = await _inputConverter
        .stringToUnsignedInt(numberText)
        .ifRightDo((value) {
          state = Loading();
        })
        .map((a) => Params(number: a))
        .bindAsync(_getConcreteNumberUseCase);

    result.fold((failure) => state = Error(message: failure.reason),
        (value) => state = Loaded(trivia: value));
  }

  getRandomTrivia() async {
    state = Loading();
    final result = await _getRandomNumberUseCase(NoParams());

    print("getRandomTrivia: {$result}");

    result.fold((failure) => state = Error(message: failure.reason),
        (value) => state = Loaded(trivia: value));
  }


}
