import 'package:clean_tdd_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/usecases/get_concrete_number_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}


void main() {
  // class to test
  late GetConcreteNumberUseCase usecase;

  // Mock repository to be able to launch the test
  late MockNumberTriviaRepository mockNumberTriviaRepository;


  // Set up test
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberUseCase(mockNumberTriviaRepository);
  });

  final tNumber = 1.0;
  final tNumberTrivia = NumberTrivia(text: 'text', number: 1);

  test (
    'should get trivia for the number from repository',
      () async {

        // "On the fly" implementation of the Repository using the Mockito package.
        // When getConcreteNumberTrivia is called with any argument, always answer with
        // the Right "side" of Either containing a test NumberTrivia object.
        //when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        //    .thenAnswer((_) async => Right(tNumberTrivia));

        when(() => mockNumberTriviaRepository.getConcreteNumberTrivia(any()))
            .thenAnswer((_) async => Right(tNumberTrivia));

        // The "act" phase of the test. Call the not-yet-existent method.
        final result = await usecase(Params(number: tNumber));

        // Test:
        // UseCase should return whatever was returned from the Repository
        expect(result, Right(tNumberTrivia));

        // Verify that the method has been called on the Repository
        verify(() => mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));

        // Only the above method should be called and nothing more.
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      }

  );

}





