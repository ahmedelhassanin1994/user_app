import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_project/core/common/network/dio_factory.dart';
import 'package:mvvm_project/core/common/network/network_info.dart';
import 'package:mvvm_project/features/features_home/data/data_source/remote_data_source_home.dart';
import 'package:mvvm_project/features/features_home/data/network/apiHome.dart';
import 'package:mvvm_project/features/features_home/data/data_source/local_data_source.dart';
import 'package:mvvm_project/features/features_home/data/repository/repositoryHome_impl.dart';
import 'package:mvvm_project/features/features_home/domain/repository/repository_home.dart';
import 'package:mvvm_project/features/features_home/domain/usecase/user_usecase.dart';
import 'package:mvvm_project/features/features_home/presentation/home_viewmodel.dart';


final instance = GetIt.instance;

Future<void> initAppModule() async {

  // networl instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<ApiHome>(() => ApiHome(dio));





  instance.registerLazySingleton<RemoteDataSourceHome>(
      () => RemoteDataSourceHomeImplementer(instance()));



  // local data source
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer());



  // repository

  instance.registerLazySingleton<RepositoryHome>(
      () => RepositoryHomeImpl(instance(), instance(), instance()));




  //Infrastructure
  instance.registerLazySingleton<Dio>(() => Dio());

  HomeModule();

}

HomeModule() {
  if (!GetIt.I.isRegistered<UserUseCase>()) {
    instance.registerFactory<UserUseCase>(() => UserUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}





restetAllModule() {
  instance.reset(dispose: true);
  initAppModule();
}

