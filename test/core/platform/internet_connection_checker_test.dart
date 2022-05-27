
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

void main() {

  // Class to test
  late InternetConnectionChecker internetChecker;

  // Instantiate repositories

  setUp( () {
    // Setup Mocks

    // Setup Class to test
    internetChecker = InternetConnectionChecker();
  });

  // Define Fixtures

  test (
    'External: InternetConnectionChecker',
          () async {
            // On the fly mock behaviour definition
            // ex: when(() => mockNetworkInfo.isConnected)
            //             .thenAnswer((_) async => true);


            // Act
            // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

            final result = await internetChecker.hasConnection;

            // Test
            // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
            // expect(() => numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber),
            //             throwsA(isA<ServerException>()));

            expect(result, true);

            // Verify
            // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
            // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);

          }
  );
}