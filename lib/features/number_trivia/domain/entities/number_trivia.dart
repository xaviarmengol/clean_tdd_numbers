import 'package:equatable/equatable.dart';

/// text : "42 is the answer to the Ultimate Question of Life, the Universe, and Everything."
/// number : 42
/// found : true
/// type : "trivia"

//https://pub.dev/packages/equatable

class NumberTrivia extends Equatable{

  final String text;
  final double number;

  const NumberTrivia({
     required this.text,
     required this.number,});

  @override
  List<Object> get props => [text, number];
}