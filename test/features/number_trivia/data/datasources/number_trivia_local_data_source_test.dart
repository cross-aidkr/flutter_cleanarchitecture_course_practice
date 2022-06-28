import 'dart:convert';

import 'package:cleanarchitecture_course/core/error/exceptions.dart';
import 'package:cleanarchitecture_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleanarchitecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main(){
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await dataSource.getLastNumberTrivia();
        // asset
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      }
    );

    test(
        'should throw a CacheException when there is not a cached value',
            () async {
          // arrange
          when(mockSharedPreferences.getString(any))
              .thenReturn("");
          // act
          final call = dataSource.getLastNumberTrivia;
          // asset
          expect(() => call(), throwsA(TypeMatcher<CacheException>()));
        }
    );
  });

  group('cacheNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'text trivia');

    test(
        'should call SharedPreferences to cache the data',
            () async {
          final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

          // arrange
          when(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString))
             .thenAnswer((_) async => Future.any([]));

          // act
          dataSource.cacheNumberTrivia(tNumberTriviaModel);
          // asset
          verify(mockSharedPreferences.setString(
              CACHED_NUMBER_TRIVIA,
              expectedJsonString)
          );
        }
    );
  });
}

