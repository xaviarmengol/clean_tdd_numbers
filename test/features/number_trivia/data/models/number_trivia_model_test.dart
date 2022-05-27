import 'package:clean_tdd_numbers/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import '../../../../fixtures/fixure_reader.dart';


void main () {

  // Set up test
  setUp(() {

  });

  NumberTriviaModel numberModel;

  test (
      'from Json',
    () async {

      // Prepare
      // Act
      var stringRaw = fixture('response.json');
      //print(stringRaw);
      numberModel = NumberTriviaModel.fromJson(
          json.decode(stringRaw)
      );

      //Test
      expect(numberModel.text, "418 is the error code for \"I'm a teapot\" in the Hyper Text Coffee Pot Control Protocol.");
      expect(numberModel.number, 418);
      expect(numberModel.found, true);
      expect(numberModel.type, "trivia");
      //Verify

    }
  );

  test (
    'from Json double',
        () async {

      // Prepare
      // Act
      numberModel = NumberTriviaModel.fromJson(
          json.decode(fixture('response_double.json'))
      );

      //Test
      expect(numberModel.text, "4e+185 is the number of planck volumes in the observable universe.");
      expect(numberModel.number, 4e+10);
      expect(numberModel.found, true);
      expect(numberModel.type, "trivia");
      //Verify

    }
  );

  test (
    'from Json negative',
        () async {

      // Prepare
      // Act
      numberModel = NumberTriviaModel.fromJson(
          json.decode(fixture('response_uninteresting.json'))
      );

      //Test
      expect(numberModel.text, "-1 is an uninteresting number.");
      expect(numberModel.number, -1);
      expect(numberModel.found, false);
      expect(numberModel.type, "trivia");
      //Verify

    }

  );

  test (
    'to Json',
      () async {

        //Prepare
        numberModel = NumberTriviaModel(text: "text", number: 0, found: false, type: "type");

        //Act
        var jsonOutput = numberModel.toJson();

        //Test
        expect(jsonOutput['text'], "text");
        expect(jsonOutput['number'], 0);
        expect(jsonOutput['found'], false);
        expect(jsonOutput['type'], "type");

        //Verify

      }
  );

}