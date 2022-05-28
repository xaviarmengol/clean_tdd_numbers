
import 'package:clean_tdd_numbers/core/error/failures.dart';
import 'package:clean_tdd_numbers/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  // Class to test
  late InputConverter inputConverter;

  setUp( () {
    // Setup Class to test
    inputConverter = InputConverter();

  });

  // Define Fixtures
  String tNumberString = '77';
  int tNumber = 77;

  String tNumberStringNegative = '-6';

  String tNoNumberString = 'a';

  test (
    'Convert to int a positive string',
          () async {
            // Act
            // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
            final result = inputConverter.stringToPositiveDouble(tNumberString);

            // Test
            // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
            expect(result, Right(tNumber));

          }
  );

  test (
      'Throw failure if string is negative',
          () async {
        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
        final result = inputConverter.stringToPositiveDouble(tNumberStringNegative);

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
        expect(result, Left(InvalidInputFailure()));
      }
  );

  test (
      'Throw failure if string is not a number',
          () async {
        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
        final result = inputConverter.stringToPositiveDouble(tNoNumberString);

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
        expect(result, Left(InvalidInputFailure()));
      }
  );
}