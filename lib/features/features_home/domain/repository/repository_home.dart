import 'package:dartz/dartz.dart';
import 'package:mvvm_project/core/common/network/failure.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';


abstract class RepositoryHome {

   Future<Either<Failure,UserEntities>> getUser(String page,String per_page);
}
