
import 'package:clean_tdd_numbers/data/number_trivia/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_tdd_numbers/domain/number_trivia/usecases/get_all_cached_numbers_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/number_trivia/datasources/number_trivia_local_data_source.dart';
import '../../core/util/input_converter.dart';
import '../../data/number_trivia/repositories/number_trivia_repository_cached_impl.dart';
import '../../domain/number_trivia/usecases/get_concrete_number_usecase.dart';
import '../../domain/number_trivia/usecases/get_random_number_usecase.dart';
import '../../presentation/number_trivia/notifier/number_trivia_notifier.dart';
import '../../presentation/number_trivia/notifier/number_trivia_state.dart';
import '../keyvalue_cache/providers_cache.dart';
import '../network_info/providers_network_info.dart';

// Just to test the providers in the Flutter package
final testFutureProvider = FutureProvider((ref) async {

  final testFuture = ref.watch(numberRemoteDataSourceProvider);
  return testFuture.getConcreteNumberTrivia(2);

});

////////////////////////


final inputConverterProvider = Provider((ref) => InputConverter());

final httpProvider = Provider ((ref) => http.Client());


final numberLocalDataSourceProvider = Provider ((ref)  {

  final keyValueLocalDataSource = ref.watch(keyValueLocalDataSourceProvider);
  return NumberTriviaLocalDataSourceImpl(keyValueLocalDataSource: keyValueLocalDataSource );
});


final numberRemoteDataSourceProvider = Provider ((ref) {
  final httpClient = ref.watch(httpProvider);
  return NumberTriviaRemoteDataSourceImpl(client: httpClient);
});


final numberTriviaRepositoryProvider = Provider( (ref)  {
  final localDataSource =  ref.watch(numberLocalDataSourceProvider);
  final remoteDataSource = ref.watch(numberRemoteDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);

  return NumberTriviaRepositoryCachedImp(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo);

});

final getConcreteNumberUseCaseProvider = Provider ((ref)  {
  final repository =  ref.watch(numberTriviaRepositoryProvider);
  return GetConcreteNumberUseCase(repository);
});

final getRandomNumberUseCaseProvider = Provider ((ref)  {
  final repository =  ref.watch(numberTriviaRepositoryProvider);
  return GetRandomNumberUseCase(repository);
});

final getAllCachedUseCaseProvider = Provider ((ref)  {
  final repository =  ref.watch(numberTriviaRepositoryProvider);
  return GetAllCachedNumbersUseCase(repository);
});


final numberNotifierProvider = StateNotifierProvider <NumberNotifier, NumberTriviaState> ((ref)  {

  final getConcreteUseCase = ref.watch(getConcreteNumberUseCaseProvider);
  final getRandomUseCase = ref.watch(getRandomNumberUseCaseProvider);
  final inputConverter = ref.watch(inputConverterProvider);

  return NumberNotifier(getConcreteUseCase, getRandomUseCase, inputConverter);

});






