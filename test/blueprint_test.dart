
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

void main() {

  // Class to test

  // Instantiate repositories

  setUp( () {
    // Setup Mocks

    // Setup Class to test


  });

  // Define Fixtures

  test (
    'Test name',
          () async {
            // On the fly mock behaviour definition
            // ex: when(() => mockNetworkInfo.isConnected)
            //             .thenAnswer((_) async => true);


            // Act
            // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);


            // Test
            // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
            // expect(() => numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber),
            //             throwsA(isA<ServerException>()));


            // Verify
            // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
            // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);

          }
  );
}