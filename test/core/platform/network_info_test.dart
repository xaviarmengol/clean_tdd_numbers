
import 'package:clean_tdd_numbers/data/platform/datasources/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker{}

void main() {

  // Class to test
  late NetworkInfoImpl networkInfo;

  // Instantiate repositories

  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp( () {
    // Setup Mocks
    mockInternetConnectionChecker = MockInternetConnectionChecker();

    // Setup Class to test
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);

  });

  // Define Fixures
  bool result;

  test (
    'Test than when there is a connection we answer true',
          () async {
            // On the fly mock behaviour definition
            // ex: when(() => mockNetworkInfo.isConnected)
            //             .thenAnswer((_) async => true);

            when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => true);

            // Act
            // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

            result = await networkInfo.isConnected;

            // Test
            // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);

            expect(result, true);

            // Verify
            // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));

            verify(() => mockInternetConnectionChecker.hasConnection);

            verifyNoMoreInteractions(mockInternetConnectionChecker);

          }
  );

  test (
      'Test than when there is No connection we answer false',
          () async {
        // On the fly mock behaviour definition
        // ex: when(() => mockNetworkInfo.isConnected)
        //             .thenAnswer((_) async => true);

        when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((invocation) async => false);

        // Act
        // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

        result = await networkInfo.isConnected;

        // Test
        // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);

        expect(result, false);

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));

        verify(() => mockInternetConnectionChecker.hasConnection);

        verifyNoMoreInteractions(mockInternetConnectionChecker);

      }
  );
}