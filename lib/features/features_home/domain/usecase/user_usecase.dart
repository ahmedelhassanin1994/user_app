import 'package:dartz/dartz.dart';
import 'package:mvvm_project/core/common/base/base_usecase.dart';
import 'package:mvvm_project/core/common/network/failure.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';
import 'package:mvvm_project/features/features_home/domain/repository/repository_home.dart';


class UserUseCase implements BaseCase<InputUseCase,UserEntities> {
  final RepositoryHome _repository;

  UserUseCase(this._repository);

  @override
  Future<Either<Failure,UserEntities>> execute(InputUseCase input) async {
    return await _repository.getUser(input.page.toString(), input.per_page.toString());
  }
}

class InputUseCase{
  String? page;
  String? per_page;

  InputUseCase(this.page, this.per_page);
}
