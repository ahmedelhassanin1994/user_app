

// to convert the response into an non nullable object (model)


import 'package:mvvm_project/features/features_home/data/responeses/model_user.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';

const EMPTY="";
const ZERO=0;
const STATUS=false;
const Double=0.0;



extension UserDataMapper on ModelUserResponse?{
  UserEntities toDomain(){

    List<UserDataEntities>? listUser=(this?.data?.map((e) => e.toDomain()) ?? Iterable.empty()).cast<UserDataEntities>().toList();

    return UserEntities(this?.page ?? ZERO,this?.perPage ?? ZERO,this?.total ?? ZERO,listUser);
  }

}



extension DataUserMapper on DataUser?{

  UserDataEntities toDomain(){
    return UserDataEntities(this?.id ?? ZERO, this?.email ?? EMPTY, this?.firstName ?? EMPTY, this?.lastName ?? EMPTY, this?.avatar ?? EMPTY);

  }
}




