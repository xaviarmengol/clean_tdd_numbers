
import 'dart:convert';

import 'package:clean_tdd_numbers/core/error/exception.dart';
import 'package:clean_tdd_numbers/core/platform/number_trivia_local_data_source.dart';
import 'package:clean_tdd_numbers/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {

  // Class to test
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;

  // Instantiate repositories
  late MockSharedPreferences mockSharedPreferences;

  setUp( () {
    // Setup Mocks
    mockSharedPreferences = MockSharedPreferences();

    // Setup Class to test
    numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

  });

  // Fixures
  var tNumber = 1;
  var tNumberString = tNumber.toString();
  var tNumberTriviaModel = NumberTriviaModel(text:"text", number:1, found:true, type:"type");


  test (
    'Test that we get the data from local preferences when there is value',
          () async {
            // On the fly mock behaviour definition
            // ex: when(() => mockNetworkInfo.isConnected)
            //             .thenAnswer((_) async => true);
            var tNumberTriviaModelRaw = json.encode(tNumberTriviaModel.toJson());
            when(() => mockSharedPreferences.getString(tNumberString)).thenAnswer((invocation) => tNumberTriviaModelRaw);


            // Act
            // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
            var result = await numberTriviaLocalDataSourceImpl.getConcreteNumberTrivia(tNumber);

            // Test
            // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
            expect(result, tNumberTriviaModel);

            // Verify
            // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
            // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
            verify(() => mockSharedPreferences.getString(tNumberString));
            verifyNoMoreInteractions(mockSharedPreferences);
          }
  );


  test (
      'Test that we throw correct exception when threre is no data to get',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);
        when(() => mockSharedPreferences.getString(tNumberString)).thenThrow(Exception('error test'));

        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);

        expect(() => numberTriviaLocalDataSourceImpl.getConcreteNumberTrivia(tNumber), throwsA(isA<CacheException>()));

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockSharedPreferences.getString(tNumberString));
      }
  );

  test (
      'Test that we throw correct exception when data that we get is NULL',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);
        var tNumberTriviaModelRaw = json.encode(tNumberTriviaModel.toJson());
        when(() => mockSharedPreferences.getString(tNumberString)).thenAnswer((invocation) => null);


        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
        expect(() => numberTriviaLocalDataSourceImpl.getConcreteNumberTrivia(tNumber), throwsA(isA<CacheException>()));


        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockSharedPreferences.getString(tNumberString));
        verifyNoMoreInteractions(mockSharedPreferences);

      }
  );

  test (
      'Test that we cached Number Trivia',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);
        var tNumberTriviaModelRaw = json.encode(tNumberTriviaModel.toJson());
        when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);



        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);
        await numberTriviaLocalDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);

        // TODO: Implement test with real delay between write and read

        //final result = await numberTriviaLocalDataSourceImpl.getLastNumber();

        // Test
        //expect(result, tNumberTriviaModel);

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockSharedPreferences.setString(NumberTriviaLocalDataSourceImpl.lastValueKey,
            tNumberTriviaModelRaw));
        verify(() => mockSharedPreferences.setString(tNumberString, tNumberTriviaModelRaw));
        verifyNoMoreInteractions(mockSharedPreferences);
      }

  );

  test (
      'Test that if we can not cache, return exception',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);
        var tNumberTriviaModelRaw = json.encode(tNumberTriviaModel.toJson());
        when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => false);


        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);

        expect(() => numberTriviaLocalDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel), throwsA(isA<CacheException>()));

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);


        verify(() => mockSharedPreferences.setString(tNumberString, tNumberTriviaModelRaw)).called(1);
        verifyNoMoreInteractions(mockSharedPreferences);
      }


  );


}