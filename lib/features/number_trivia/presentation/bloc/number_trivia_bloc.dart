
import 'package:bloc/bloc.dart';
import 'package:clean_tdd_numbers/core/util/either_extension.dart';
import 'package:clean_tdd_numbers/core/util/input_converter.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/usecases/get_concrete_number_usecase.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/usecases/get_random_number_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../notifier/number_trivia_state.dart';

part 'number_trivia_event.dart';

// https://github.com/felangel/bloc/blob/master/packages/bloc/README.md


class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {

  final GetConcreteNumberUseCase getConcreteNumberUseCase;
  final GetRandomNumberUseCase getRandomNumberUseCase;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberUseCase,
    required this.getRandomNumberUseCase,
    required this.inputConverter}): super (Empty()) {

      on<GetTriviaForConcreteNumberEvent>(

        (event, emit) async {

            var result = await inputConverter.stringToUnsignedInt(event.numberString)
                .ifRightDo((value) {emit(Loading());})
                .map((a) => Params(number: a))
                .bindAsync(getConcreteNumberUseCase);

            result.fold(
                    (failure) => emit(Error(message: failure.reason)),
                    (value) => emit(Loaded(trivia: value)) //
            );
        }
      );

      on<GetTriviaForRandomNumberEvent>(

          (event, emit) async {
            emit(Loading());
            var result = await getRandomNumberUseCase(NoParams());

            result.fold(
                  (failure) => emit(Error(message: failure.reason)),
                  (value) => emit(Loaded(trivia: value))
            );
          }
      );

    }
}
