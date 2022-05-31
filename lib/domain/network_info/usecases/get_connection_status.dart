
import 'package:clean_tdd_numbers/core/error/failures.dart';
import 'package:clean_tdd_numbers/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../data/network_info/repositories/network_info_repostitory_impl.dart';


class GetConnectionStatusUseCase extends UseCase<bool, NoParams> {
  final NetworkInfoRepositoryImpl networkInfoRepositoryImpl;

  GetConnectionStatusUseCase(this.networkInfoRepositoryImpl);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return networkInfoRepositoryImpl.isConnected;
  }

  // TODO: How a stream should be implemented in the usecase?

  Stream<bool> onStatusChange() {
    return networkInfoRepositoryImpl.onStatusChange;
  }
}