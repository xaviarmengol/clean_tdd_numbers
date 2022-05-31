import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:clean_tdd_numbers/domain/number_trivia/entities/number_trivia.dart';
import 'package:clean_tdd_numbers/domain/number_trivia/repositories/number_trivia_repository.dart';
import 'package:clean_tdd_numbers/domain/number_trivia/usecases/get_random_number_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  // class to test
  late GetRandomNumberUseCase usecase;

  // Mock repository to be able to launch the test
  late MockNumberTriviaRepository mockNumberTriviaRepository;


  // Set up test
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberUseCase(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(text: 'text', number: 1);

  test (
    'should get random number trivia from repository',
      () async {


        when(() => mockNumberTriviaRepository.getRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));

        // The "act" phase of the test. Call the not-yet-existent method.
        final result = await usecase(NoParams());

        // Test:
        // UseCase should return whatever was returned from the Repository
        expect(result, Right(tNumberTrivia));

        // Verify that the method has been called on the Repository
        verify(() => mockNumberTriviaRepository.getRandomNumberTrivia());

        // Only the above method should be called and nothing more.
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      }

  );

}





