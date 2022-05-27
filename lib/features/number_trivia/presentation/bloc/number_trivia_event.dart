part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];

}

class GetTriviaForConcreteNumberEvent extends NumberTriviaEvent {
  final String numberString;

  const GetTriviaForConcreteNumberEvent({required this.numberString});

  @override
  List<Object> get props => [numberString];

}

class GetTriviaForRandomNumberEvent extends NumberTriviaEvent {


}

