
import 'dart:convert';

import 'package:clean_tdd_numbers/core/error/exception.dart';
import 'package:clean_tdd_numbers/data/number_trivia/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_tdd_numbers/data/number_trivia/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixure_reader.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockHttp extends Mock implements http.Client {}

void main() {

  // Class to test
  late NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;

  // Instantiate repositories
  late MockHttp mockHttp;

  setUp( () {
    // Setup Mocks
    mockHttp = MockHttp();

    // Setup Class to test
    numberTriviaRemoteDataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttp);

    registerFallbackValue(Uri());

  });

  // Define Fixtures
  var tNumber = 1.0;
  var responseRaw = fixture('response.json');
  var responseJson = json.decode(responseRaw);
  var tHeaders = {'Content-Type': 'application/json'};

  test (
      'Getconcrete answer correct data, when code 200',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);
            when(() => mockHttp.get(
                any(), headers: tHeaders
            )).thenAnswer((_) async => http.Response (responseRaw, 200));

        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
            var result = await numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber);

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
            expect(result, NumberTriviaModel.fromJson(responseJson));

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
            verify(() => mockHttp.get(any(), headers: tHeaders));
            verifyNoMoreInteractions(mockHttp);
      }
  );


  test (
      'Getconcrete launch exception when response is NOT 200',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);
        when(() => mockHttp.get(
            any(), headers: tHeaders
        )).thenAnswer((_) async => http.Response (responseRaw, 400));

        // Assert
        expect(() => numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber),
            throwsA(isA<ServerException>())); //

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockHttp.get(any(), headers: tHeaders));
        verifyNoMoreInteractions(mockHttp);
      }
  );
}