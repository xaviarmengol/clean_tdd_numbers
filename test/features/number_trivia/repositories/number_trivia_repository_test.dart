

import 'package:clean_tdd_numbers/core/platform/network_info.dart';
import 'package:clean_tdd_numbers/core/platform/number_trivia_local_data_source.dart';
import 'package:clean_tdd_numbers/core/platform/number_trivia_remote_datasource.dart';
import 'package:clean_tdd_numbers/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_tdd_numbers/features/number_trivia/data/repositories/number_trivia_repository_cached_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}
class MockNumberTriviaLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}


void main() {
  // class to test
  late NumberTriviaRepositoryCachedImp repositoryImp;

  // Mock repository to be able to launch the test
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  // Set up test
  setUp(() {
    // Set up Mocks
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    // Set up class to test
    repositoryImp = NumberTriviaRepositoryCachedImp(
      remoteDataSource: mockNumberTriviaRemoteDataSource,
      localDataSource: mockNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  // Define fixures

  var tNumber = 1.0;
  var tNumberTriviaModel = NumberTriviaModel(text:"text", number:1, found:true, type:"type");
  var tNumberTriviaLastModel = NumberTriviaModel(text:"last", number:99, found:true, type:"type");


  test(
      'should check if the device is online',
          () async {
        // On the flight definition
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((_) async => true);

        // The "act" phase of the test.
        final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        // Verify that the method has been called on the Repository
        verify(() =>  mockNetworkInfo.isConnected);

      }
  );

  test(
      'should check that answer the concrete remote data source when online',
          () async {
        // On the flight definition

        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((_) async => true);
        when(() => mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((invocation) async => tNumberTriviaModel);
        when(() => mockNumberTriviaLocalDataSource.getConcreteNumberTrivia(tNumber)). thenAnswer((invocation) => tNumberTriviaModel);

        // TODO: Redo test


        // The "act" phase of the test.
        final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        // Test:
        expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);

        // Verify that the methods have been called on the Repository
        verify(() =>  mockNetworkInfo.isConnected);
        verify(() => mockNumberTriviaLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        //verify(() =>  mockNumberTriviaLocalDataSource.getLastNumber());

        // Verify
        verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
      }
  );

  test(
      'should check that answer the local value when is off-line and local value exists',
          () async {
        // On the flight definition

        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((_) async => false);
        when(() => mockNumberTriviaLocalDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((invocation) => tNumberTriviaLastModel);

        //TODO: Redo tests

        // The "act" phase of the test.
        final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        // Test:
        expect(result, Right(tNumberTriviaLastModel.toNumberTrivia()),);

        // Verify that the methods have been called on the Repository
        verify(() =>  mockNetworkInfo.isConnected);
        //verify(() =>  mockNumberTriviaLocalDataSource.getLastNumber());

        // Verify that random has not been called
        verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
      }
  );

  // TODO: Finish the test when there are connection errors or no local value in place


}
