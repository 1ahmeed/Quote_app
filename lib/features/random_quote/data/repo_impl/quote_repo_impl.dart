import 'package:dartz/dartz.dart';
import 'package:quotes/core/errors/exceptions.dart';
import 'package:quotes/core/errors/failures.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/random_quote/domain/entity/quote_entity.dart';
import 'package:quotes/features/random_quote/domain/repo/quote_repo.dart';

import '../data_sources/quote_local_data_source.dart';
import '../data_sources/quote_remote_data_source.dart';

class QuoteRepoImpl implements QuoteRepo {
  final NetworkInfo networkInfo;
  final QuoteRemoteDataSource remoteDataSource;
  final QuoteLocalDataSource localDataSource;

  QuoteRepoImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, QuoteEntity>> getQuotes() async {
     if (await networkInfo.isConnected) {
      try {
        final remoteQuote = await remoteDataSource.getQuotes();
        localDataSource.cacheQuotes(remoteQuote);
        return Right(remoteQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final cacheQuote = await localDataSource.getQuotes();
        return Right(cacheQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
   }
  }
}
