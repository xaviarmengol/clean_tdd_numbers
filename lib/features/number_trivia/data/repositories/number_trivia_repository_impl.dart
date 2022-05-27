
import 'package:clean_tdd_numbers/core/error/failures.dart';
import 'package:clean_tdd_numbers/core/platform/network_info.dart';
import 'package:clean_tdd_numbers/core/platform/number_trivia_local_data_source.dart';
import 'package:clean_tdd_numbers/core/platform/number_trivia_remote_datasource.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd_numbers/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/number_trivia_model.dart';

typedef Future<NumberTriviaModel> _GenericFun();

class NumberTriviaRepositoryImp implements NumberTriviaRepository {

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number) async {
    return _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number ?? 0));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }


  Future<Either<Failure, NumberTrivia>> _getTrivia(_GenericFun func) async {

    NumberTriviaModel numberTriviaModelFromRemote;
    NumberTriviaModel numberTriviaModel;
    Either<Failure, NumberTrivia> numberTriviaResult = Left(CacheFailure());

    // We try to upload from network and catch
    if (await networkInfo.isConnected) {
      try {
        numberTriviaModelFromRemote = await func();
        //print("Repository -> ReadRemote: {$numberTriviaModelFromRemote}");
        await localDataSource.cacheNumberTrivia(numberTriviaModelFromRemote);
      } catch (e) {
        print("Error connecting to network or caching the value");
      }
    } else {
      print("No network available");
    }


    // One source of truth
    try {
      numberTriviaModel = await localDataSource.getLastNumber();
      //print("Repository -> GetLastNumber: {$numberTriviaModel}");

      numberTriviaResult = Right(numberTriviaModel.toNumberTrivia());
    } catch (e) {
      print("Error loading data from local ");
    }

    //print("NumberTriviaRepositoryImp: {$numberTriviaResult}");

    return numberTriviaResult;
  }


}


