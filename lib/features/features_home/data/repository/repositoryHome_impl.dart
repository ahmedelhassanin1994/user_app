

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mvvm_project/core/common/data/model/model_cache.dart';
import 'package:mvvm_project/core/common/network/error_handler.dart';
import 'package:mvvm_project/core/common/network/failure.dart';
import 'package:mvvm_project/core/common/network/network_info.dart';
import 'package:mvvm_project/core/constant.dart';
import 'package:mvvm_project/features/features_home/data/data_source/remote_data_source_home.dart';
import 'package:mvvm_project/features/features_home/data/data_source/local_data_source.dart';
import 'package:mvvm_project/features/features_home/data/mapper/mapper_home.dart';
import 'package:mvvm_project/features/features_home/data/responeses/model_user.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';
import 'package:mvvm_project/features/features_home/domain/repository/repository_home.dart';


class RepositoryHomeImpl extends RepositoryHome {
  late RemoteDataSourceHome _remoteDataSource;
  late LocalDataSource localDataSource;
  late NetworkInfo _networkInfo;

  RepositoryHomeImpl(this._remoteDataSource, this._networkInfo, this.localDataSource);



  @override
  Future<Either<Failure,UserEntities>> getUser(String page,String per_page) async{
    // TODO: implement categories
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUser(page, per_page);

        Model_Cache modelcache=new Model_Cache(Constant.localKey,jsonEncode(response));
        localDataSource.AddCache(modelcache);
        return Right(response.toDomain());

      } catch (e) {
        print("error : $e");
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NI_INTERNET_CONNECTION.getFailure());
    }

  }

}
