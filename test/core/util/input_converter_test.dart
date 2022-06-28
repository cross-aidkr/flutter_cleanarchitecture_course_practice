import 'package:cleanarchitecture_course/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late InputConverter inputConverter;

  setUp((){
    inputConverter = InputConverter();
  });

  group('stringToUnsingedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
        () async {
          // arrange
          final str = '123';
          // act
          final result = inputConverter.stringToUnsignedInteger(str);
          // asset
          expect(result, Right(123));
        }
    );

    test(
        'should return a Failure when the string is not an integer',
            () async {
          // arrange
          final str = 'abc';
          // act
          final result = inputConverter.stringToUnsignedInteger(str);
          // asset
          expect(result, Left(InvalidInputFailure()));
        }
    );

    test(
        'should return a Failure when the string is a negative integer',
            () async {
          // arrange
          final str = '-123';
          // act
          final result = inputConverter.stringToUnsignedInteger(str);
          // asset
          expect(result, Left(InvalidInputFailure()));
        }
    );
  });
}