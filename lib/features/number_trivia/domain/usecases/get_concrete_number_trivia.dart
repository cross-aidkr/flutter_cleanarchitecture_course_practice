import 'package:cleanarchitecture_course/core/error/failures.dart';
import 'package:cleanarchitecture_course/core/usecases/usecase.dart';
import 'package:cleanarchitecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitecture_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(
      Params params,
  ) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({required this.number}) : super();

  @override
  // TODO: implement props
  List<Object?> get props => [number];
}