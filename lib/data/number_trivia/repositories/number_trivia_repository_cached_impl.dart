
import 'package:clean_tdd_numbers/core/error/failures.dart';
import 'package:clean_tdd_numbers/data/number_trivia/datasources/number_trivia_local_data_source.dart';
import 'package:clean_tdd_numbers/data/number_trivia/datasources/number_trivia_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/number_trivia/entities/number_trivia.dart';
import '../../../domain/number_trivia/repositories/number_trivia_repository.dart';
import '../../platform/datasources/network_info.dart';
import '../models/number_trivia_model.dart';

typedef ReturnFutureModelFun = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryCachedImp implements NumberTriviaRepository {

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryCachedImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(double? number) async {
    return _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number ?? 0), number: number ?? 0);
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }


  Future<Either<Failure, NumberTrivia>> _getTrivia(ReturnFutureModelFun getRemoteData, {double? number}) async {

    NumberTriviaModel numberTriviaModelFromRemote;
    NumberTriviaModel numberTriviaModel;
    Either<Failure, NumberTrivia> numberTriviaResult = Left(CacheFailure());

    double numToGet = number ?? 0;
    bool noNumberProvided = number == null;
    bool remoteNumberOk = false;

    // We try to upload from network and catch
    if (await networkInfo.isConnected) {
      try {
        numberTriviaModelFromRemote = await getRemoteData();
        numToGet = numberTriviaModelFromRemote.number ?? 0.0;

        print("Repository -> ReadRemote: {$numberTriviaModelFromRemote}");
        await localDataSource.cacheNumberTrivia(numberTriviaModelFromRemote);
        remoteNumberOk = true;
      } catch (e) {
        print("Error connecting to network or caching the value");
      }
    } else {
      print("No network available");
    }


    // One source of truth
    try {

      if (noNumberProvided && !remoteNumberOk) {
        // If remote error and random, give a random cached number
        print('Getting random from cache: No number provided');
        numberTriviaModel = localDataSource.getRandomCachedNumber();

      } else {
        numberTriviaModel = localDataSource.getConcreteNumberTrivia(numToGet);
      }

      //print("Repository -> getConcreteNumberTrivia: {$numberTriviaModel}");
      numberTriviaResult = Right(numberTriviaModel.toNumberTrivia());
    } catch (e) {
      print("Error loading data from local - Concrete number ");
      print(e.toString());
      numberTriviaResult = Left(CacheFailure());

    }

    //print("NumberTriviaRepositoryImp: {$numberTriviaResult}");

    return numberTriviaResult;
  }

  @override
  Either<Failure, Set<NumberTrivia>> getAllCachedNumbers() {
    try {
      final setNumberTriviaModel = localDataSource.getAllCachedNumbers();
      final setNumberTrivia = setNumberTriviaModel.map((numberTriviaModel) => numberTriviaModel.toNumberTrivia()).toSet();
      return Right(setNumberTrivia);
    } catch (e) {
      print(e.toString());
      return Left(CacheFailure());
    }
  }



}


