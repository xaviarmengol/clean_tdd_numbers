
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

void main() {

  // Class to test
  late Future<SharedPreferences> _sharedPreferences;
  late SharedPreferences sharedPreferences;

  // Instantiate repositories

  setUp( () {
    // Setup Mocks

    // Setup Class to test
    _sharedPreferences = SharedPreferences.getInstance();

  });

  // Define Fixures
  var key = 'key';
  var value = 'value';

  test (
    'Shared Preferences set and get string works well',
          () async {
            // On the fly mock behaviour definition
            // ex: when(() => mockNetworkInfo.isConnected)
            //             .thenAnswer((_) async => true);

            sharedPreferences = await _sharedPreferences;

            // Act
            // ex: final result = await repositoryImp.getConcreteNumberTrivia(tNumber);

            sharedPreferences.setString(key, value);

            var result = sharedPreferences.getString(key);

            // Test
            // ex: expect(result, Right(tNumberTriviaModel.toNumberTrivia()),);
            expect(result, value);

            // Verify
            // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
            // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);

          }
  );
}