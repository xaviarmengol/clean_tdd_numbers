

import 'package:clean_tdd_numbers/data/network_info/repositories/network_info_repostitory_impl.dart';
import 'package:clean_tdd_numbers/domain/network_info/usecases/get_connection_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/platform/datasources/network_info.dart';

final internetCheckerProvider = Provider ((ref) => InternetConnectionChecker());

final networkInfoProvider = Provider((ref)  {
  final internetChecker = ref.read(internetCheckerProvider);
  return NetworkInfoImpl(internetChecker);
});

final networkInfoRepositoryProvider = Provider((ref)  {
  final networkInfo = ref.read(networkInfoProvider);
  return NetworkInfoRepositoryImpl(networkInfo);
});

final getConnectionUseCaseProvider = Provider ((ref)  {
  final repository =  ref.watch(networkInfoRepositoryProvider);
  return GetConnectionStatusUseCase(repository);
});