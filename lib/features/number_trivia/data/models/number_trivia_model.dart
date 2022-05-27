import 'dart:convert';
import 'dart:core';

import 'package:clean_tdd_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';

/// text : "418 is the error code for \"I'm a teapot\" in the Hyper Text Coffee Pot Control Protocol."
/// number : 418
/// found : true
/// type : "trivia"

class NumberTriviaModel extends Equatable {
  NumberTriviaModel({
      String? text,
      int? number,
      bool? found,
      String? type,}){
    _text = text;
    _number = number;
    _found = found;
    _type = type;
  }

  // Named constructor
  NumberTriviaModel.fromJson(Map<String, dynamic> json) {

    //final json = jsonDecode(jsonRaw ?? "{}");

    var numDouble = double.parse(json['number'].toString());
    var num = numDouble.toInt();

    _text = json['text'];
    _number = num;
    _found = json['found'];
    _type = json['type'];
  }

  String? _text;
  int? _number;
  bool? _found;
  String? _type;

  String? get text => _text;
  int? get number => _number;
  bool? get found => _found;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['number'] = _number;
    map['found'] = _found;
    map['type'] = _type;

    return map;
  }

  NumberTrivia toNumberTrivia() {
    return NumberTrivia (
        number: _number ?? 0,
        text: _text ?? ""
    );
  }

  @override
  List<Object?> get props => [text, number, found, type];

}