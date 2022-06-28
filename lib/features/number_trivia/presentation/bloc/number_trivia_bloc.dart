import 'package:bloc/bloc.dart';
import 'package:cleanarchitecture_course/core/error/failures.dart';
import 'package:cleanarchitecture_course/core/util/input_converter.dart';
import 'package:cleanarchitecture_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:cleanarchitecture_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';

import 'number_trivia_event.dart';
import 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()){
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  @override
  NumberTriviaState get initialState => Empty();

  void _onGetTriviaForConcreteNumber(GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    try {
      emit(Empty());

      final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);

      await inputEither.fold(
          (failure) async {
            emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
          },
          (integer) async {
            emit(Loading());
            final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));

            emit(failureOrTrivia.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)),
                (trivia) => Loaded(trivia: trivia)
            ));
          }
      );
    } catch (_) {
      emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
    }

  }

  void _onGetTriviaForRandomNumber(GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    try {
      emit(Empty());

      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      emit(failureOrTrivia.fold(
              (failure) => Error(message: _mapFailureToMessage(failure)),
              (trivia) => Loaded(trivia: trivia)
      ));

    } catch (_) {
      emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
    }


  }

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
