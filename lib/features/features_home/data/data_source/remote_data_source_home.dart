
import 'dart:convert';

import 'package:mvvm_project/features/features_home/data/network/apiHome.dart';
import 'package:mvvm_project/features/features_home/data/responeses/model_user.dart';

abstract class RemoteDataSourceHome {


   Future<ModelUserResponse> getUser(String page,String per_page);


}

 class RemoteDataSourceHomeImplementer implements RemoteDataSourceHome {
  final ApiHome _appServiceClient;

  RemoteDataSourceHomeImplementer(this._appServiceClient);

  @override
  Future<ModelUserResponse> getUser(String page, String per_page) async{
    // TODO: implement getUser
   return await _appServiceClient.getUser(page, per_page);

  }




}
