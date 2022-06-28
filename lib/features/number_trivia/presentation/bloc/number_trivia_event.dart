import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable{
  NumberTriviaEvent([List props = const <dynamic>[]]) : super();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent{
  final String numberString;
  int get number => int.parse(numberString);

  GetTriviaForConcreteNumber(this.numberString) : super([numberString]);

  @override
  List<Object?> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent{
  @override
  List<Object?> get props => [];
}