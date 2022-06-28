import 'package:cleanarchitecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';

abstract class NumberTriviaState extends Equatable{
  NumberTriviaState([List props = const <dynamic>[]]) : super();
}

class Empty extends NumberTriviaState {
  @override
  List<Object?> get props => [];
}

class Loading extends NumberTriviaState{
  @override
  List<Object?> get props => [];
}

class Loaded extends NumberTriviaState{
  final NumberTrivia trivia;

  Loaded({
    required this.trivia
  }) : super();

  @override
  List<Object?> get props => [trivia];
}

class Error extends NumberTriviaState{
  final String message;

  Error({
    required this.message
  }) : super();

  @override
  List<Object?> get props => [message];
}