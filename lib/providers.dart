
import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'core/platform/number_trivia_local_data_source.dart';
import 'core/platform/number_trivia_remote_datasource.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_usecase.dart';
import 'features/number_trivia/domain/usecases/get_random_number_usecase.dart';
import 'features/number_trivia/presentation/notifier/number_trivia_notifier.dart';
import 'features/number_trivia/presentation/notifier/number_trivia_state.dart';

// Just to test the providers in the Flutter package
final testFutureProvider = FutureProvider((ref) async {

  final testFuture = ref.watch(numberRemoteDataSourceProvider);
  return testFuture.getConcreteNumberTrivia(2);

});

////////////////////////

final internetCheckerProvider = Provider ((ref) => InternetConnectionChecker());

final inputConverterProvider = Provider((ref) => InputConverter());


final httpProvider = Provider ((ref) => http.Client());

final networkInfoProvider = Provider((ref)  {
  final internetChecker = ref.read(internetCheckerProvider);
  return NetworkInfoImpl(internetChecker);
});


final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});




final numberLocalDataSourceProvider = Provider ((ref)  {

  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return NumberTriviaLocalDataSourceImpl(sharedPreferences:sharedPreferences);
});


final numberRemoteDataSourceProvider = Provider ((ref) {
  final httpClient = ref.watch(httpProvider);
  return NumberTriviaRemoteDataSourceImpl(client: httpClient);
});


final numberTriviaRepositoryProvider = Provider( (ref)  {
  final localDataSource =  ref.watch(numberLocalDataSourceProvider);
  final remoteDataSource = ref.watch(numberRemoteDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);

  return NumberTriviaRepositoryImp(
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


final numberNotifierProvider = StateNotifierProvider <NumberNotifier, NumberTriviaState> ((ref)  {

  final getConcreteUseCase = ref.watch(getConcreteNumberUseCaseProvider);
  final getRandomUseCase = ref.watch(getRandomNumberUseCaseProvider);
  final inputConverter = ref.watch(inputConverterProvider);

  return NumberNotifier(getConcreteUseCase, getRandomUseCase, inputConverter);

});






