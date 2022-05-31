
import 'package:clean_tdd_numbers/data/platform/datasources/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/error/failures.dart';

abstract class NetworkInfoRepository {

  Future<Either<Failure, bool>> get isConnected;
  Stream<bool> get onStatusChange;

}

class NetworkInfoRepositoryImpl implements NetworkInfoRepository {

  final NetworkInfo networkInfo;
  NetworkInfoRepositoryImpl(this.networkInfo);

  @override
  Future<Either<Failure, bool>> get isConnected async {
    try {
      return Right(await networkInfo.isConnected);
    } catch (e) {
      print(e.toString());
      return Left(EthernetCheckerFailure());
    }

  }

  @override
  Stream<bool> get onStatusChange => networkInfo.onStatusChange.map((event) {
    if (event == InternetConnectionStatus.connected) {return true;}
    else {return false;}
  });

}