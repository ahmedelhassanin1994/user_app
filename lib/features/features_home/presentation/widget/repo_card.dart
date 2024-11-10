import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/core/resources/constants/assets_manager.dart';
import 'package:mvvm_project/core/resources/constants/color_manager.dart';
import 'package:mvvm_project/core/resources/constants/fonts_manager.dart';
import 'package:mvvm_project/core/resources/constants/styles_manger.dart';
import 'package:mvvm_project/core/resources/constants/value_manager.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RepoCard extends StatelessWidget {
  final UserDataEntities reposEntities;

  RepoCard(this.reposEntities);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s25.h,
      decoration: BoxDecoration(
        color: ColorManager.select,
        borderRadius: BorderRadius.circular(AppRadius.r3.w),
          image: DecorationImage(image: NetworkImage(reposEntities.avatar),
              fit: BoxFit.fill)
      ),
      margin: EdgeInsets.only(left: AppMargin.m2.w, right: AppMargin.m2.w,top: AppMargin.m1.h),
      padding: EdgeInsets.symmetric(horizontal: AppPading.p8.w, vertical: AppMargin.m2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        children: [
         Container(
           decoration: BoxDecoration(
               color: ColorManager.grey.withOpacity(.4),
               borderRadius: BorderRadius.circular(AppRadius.r3.w)
           ),
           padding: EdgeInsets.all(AppPading.p2.w),
           child: Text("${reposEntities.firstName} ${reposEntities.lastName}", maxLines: 2,
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s14.sp,
                      ),
                    ),
         ),
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Text("${reposEntities.firstName} ${reposEntities.lastName}",
          //             maxLines: 2,
          //             style: getBoldStyle(
          //               color: ColorManager.black,
          //               fontSize: FontSize.s14.sp,
          //             ),
          //           ),
          //           Text("${reposEntities.email}",
          //             maxLines: 2,
          //             style: getBoldStyle(
          //               color: ColorManager.black,
          //               fontSize: FontSize.s14.sp,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: AppMargin.m2.h),



        ],
      ),
    );
  }
}
