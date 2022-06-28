import 'package:cleanarchitecture_course/core/error/exceptions.dart';
import 'package:cleanarchitecture_course/core/error/failures.dart';
import 'package:cleanarchitecture_course/core/network/network_info.dart';
import 'package:cleanarchitecture_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleanarchitecture_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:cleanarchitecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:cleanarchitecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitecture_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    // TODO: implement getConcreteNumberTrivia
    //throw UnimplementedError();
    return await _getTrivia((){
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    // TODO: implement getRandomNumberTrivia
    //throw UnimplementedError();
    return await _getTrivia((){
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(_ConcreteOrRandomChooser getConcreteOrRandom) async {

    if(await networkInfo.isConnected){
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      try{
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }

}