
import 'package:dio/dio.dart';
import 'package:mvvm_project/core/constant.dart';
import 'package:mvvm_project/features/features_home/data/responeses/model_user.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'apiHome.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class ApiHome {
  factory ApiHome(Dio dio, {String baseUrl}) = _ApiHome;


  @GET("api/users")
  Future<ModelUserResponse> getUser(@Query('page') String page,@Query('per_page') String per_page,);

}
