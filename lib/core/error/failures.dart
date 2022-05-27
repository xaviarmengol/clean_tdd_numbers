
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.

  // https://resocoder.com/2019/08/29/flutter-tdd-clean-architecture-course-2-entities-use-cases/

  final reason = "No specified error";

  @override
  List<Object> get props => [reason];

}

class ServerFailure extends Failure{
  @override
  String get reason => "Server error";
}

class CacheFailure extends Failure {
  @override
  String get reason => "Cache can not be loaded";
}

class InvalidInputFailure extends Failure {
  @override
  String get reason => "Invalid Input";
}

