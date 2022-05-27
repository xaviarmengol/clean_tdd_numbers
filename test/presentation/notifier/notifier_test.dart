
import 'package:clean_tdd_numbers/core/util/input_converter.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/usecases/get_concrete_number_usecase.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/usecases/get_random_number_usecase.dart';
import 'package:clean_tdd_numbers/features/number_trivia/presentation/notifier/number_trivia_notifier.dart';
import 'package:clean_tdd_numbers/features/number_trivia/presentation/notifier/number_trivia_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//import 'package:state_notifier_test/state_notifier_test.dart';

// Mock repositories
// ex: class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockGetConcreteNumberUseCase extends Mock implements GetConcreteNumberUseCase {}
class MockGetRandomNumberUseCase extends Mock implements GetRandomNumberUseCase {}
class MockInputConverter extends Mock implements InputConverter {}

class FakeParams extends Fake implements Params {}

void main() {

  // Class to test
  late NumberNotifier numberNotifier;
  late NumberTriviaState state;

  // Instantiate repositories
  late MockGetConcreteNumberUseCase mockGetConcreteNumberUseCase;
  late MockGetRandomNumberUseCase mockGetRandomNumberUseCase;
  late MockInputConverter mockInputConverter;

  setUp( () {
    registerFallbackValue(FakeParams());

    // Setup Mocks
    mockGetConcreteNumberUseCase = MockGetConcreteNumberUseCase();
    mockGetRandomNumberUseCase = MockGetRandomNumberUseCase();
    mockInputConverter = MockInputConverter();

    // Setup Class to test

    numberNotifier = NumberNotifier(
        mockGetConcreteNumberUseCase,
        mockGetRandomNumberUseCase,
        mockInputConverter);

  });

  // Define Fixtures

  // The event takes in a String
  const tNumberString = '1';

  // This is the successful output of the InputConverter
  int tNumberParsed = int.parse(tNumberString);

  // NumberTrivia instance is needed too, of course
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');


  test (
      'Initial state is correct',
          () async {
        expect(numberNotifier.state, Empty());
      }
  );

  // https://codewithandrea.com/articles/async-tests-streams-flutter/

  test (
      'Concrete Event test case',
          () async {
        // On the fly mock behaviour definition

        when(() => mockInputConverter.stringToUnsignedInt(tNumberString))
            .thenAnswer((_) => Right(tNumberParsed));

        when(() =>
            mockGetConcreteNumberUseCase(Params(number: tNumberParsed)))
            .thenAnswer((_) async => const Right(tNumberTrivia));


        // Test expect first

        final expected = <NumberTriviaState>[
          Loading(),
          Loaded(trivia: tNumberTrivia)
        ];

        expectLater(numberNotifier.stream, emitsInOrder(expected));

        // Act Later
        // ex:  await repositoryImp.getConcreteNumberTrivia(tNumber);

        await numberNotifier.getConcreteTrivia(tNumberString);

        // Verify
        // ex: verify(() =>  mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        // ex: verifyNoMoreInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockGetConcreteNumberUseCase(Params(number: tNumberParsed))).called(1);
      },
    timeout: const Timeout(Duration(milliseconds: 500)),
  );





}