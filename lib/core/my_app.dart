import 'package:flutter/material.dart';
import 'package:mvvm_project/core/di.dart';
import 'package:mvvm_project/core/resources/constants/theme_manager.dart';
import 'package:mvvm_project/core/resources/router/app_router.dart';
import 'package:mvvm_project/core/resources/router/router_path.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../features/features_home/presentation/home_viewmodel.dart';


class MyApp extends StatefulWidget {
  MyApp._internal();
  static final MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  HomeViewModel homeViewModel= instance<HomeViewModel>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return   MultiProvider(
      providers: [
    ChangeNotifierProvider<HomeViewModel>.value(
    value: homeViewModel,
    ),
      ],
     child: ResponsiveSizer(builder: (context, orientation, deviceType) {
       return MaterialApp(
           onGenerateRoute: RouteGenerator.getRoute,
           debugShowCheckedModeBanner: false,
           initialRoute: Routes.all_routs,
           theme: getApplicationTheme(),
       );

    }));
  }
}
