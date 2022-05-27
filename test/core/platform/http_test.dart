
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

void main() {

  // Class to test
  late http.Client client;

  setUp( () {
    // Setup Class to test
    client = http.Client();
  });

  var tNumber = 100;

  test (
      'http gets vs. external API http://numbersapi.com',
          () async {

        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
        var response = await client.get(
            Uri.parse('http://numbersapi.com/$tNumber'),
            headers: {'Content-Type': 'application/json'}
        );
        var result = json.decode(response.body)['number'];

        // Assert
        expect(result, tNumber);

      },
    skip: 'Test only to check if external service works'
  );
}