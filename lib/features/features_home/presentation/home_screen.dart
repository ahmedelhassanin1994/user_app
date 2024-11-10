import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mvvm_project/core/di.dart';
import 'package:mvvm_project/core/resources/constants/fonts_manager.dart';
import 'package:mvvm_project/core/resources/constants/strings_manager.dart';
import 'package:mvvm_project/core/resources/constants/styles_manger.dart';
import 'package:mvvm_project/core/resources/responsive.dart';
import 'package:mvvm_project/core/resources/constants/color_manager.dart';
import 'package:mvvm_project/core/resources/constants/value_manager.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';
import 'package:mvvm_project/features/features_home/presentation/home_viewmodel.dart';
import 'package:mvvm_project/features/features_home/presentation/widget/repo_card.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {

 const HomeScreen();

  @override
  _HomeScreen createState() => _HomeScreen();
}


class _HomeScreen extends State<HomeScreen> {

  HomeViewModel homeViewModel= instance<HomeViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  List<UserDataEntities> searchCharacters=[];
  List<UserDataEntities> allCharacters=[];



   @override
  void initState() {
    // TODO: implement initState
     _scrollController.addListener(_scrollListener);
     super.initState();
  }


   @override
   void dispose() {
     _scrollController.dispose();

     super.dispose();
   }
  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: ColorManager.grey,
      decoration: InputDecoration(
        hintText: AppStrings.Search,
        border: InputBorder.none,
        hintStyle: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14,)
      ),
      style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14,),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }
  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    searchCharacters = allCharacters
        .where((character) =>
        character.firstName.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }
  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: ColorManager.grey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: ColorManager.grey,
          ),
        ),
      ];
    }
  }
  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });}
  void _scrollListener() {
    final isLoading=  Provider.of<HomeViewModel>(context, listen: false).isLoading;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 && !isLoading) {
      Provider.of<HomeViewModel>(context, listen: false).getUsersLoadMore();
    }
  }

  Widget getUsers() {

    return   Consumer<HomeViewModel>(
        builder: (_, value, __) {
          if(value.stateUsers == UsersLoadState.loading){
            return Center(child: CircularProgressIndicator());
          } if(value.stateUsers == UsersLoadState.loaded  ||  value.stateUsers == UsersLoadState.loadMore ||  value.stateUsers == UsersLoadState.noMore){
            final characters =value.users;
            allCharacters = characters;

            return    Expanded(child:    MasonryGridView.builder(
                  gridDelegate:
                   SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _searchTextController.text.isEmpty
                      ? allCharacters.length+1
                      : searchCharacters.length,
                  itemBuilder: (context, index) {
                    if (index == value.users.length) {
                      return value.isLoading
                          ? Container(
                          width: AppSize.s100.w,
                          child: Center(child: CircularProgressIndicator(color: ColorManager.primary,)))
                          : SizedBox.shrink();
                    }
                    return InkWell(
                        onTap: (){
                          showMenu(context,_searchTextController.text.isEmpty ?allCharacters[index]:searchCharacters[index]);

                        },

                        child:Hero(
                          tag: "#${value.users[index].id}",
                          transitionOnUserGestures: true,

                          child: RepoCard( _searchTextController.text.isEmpty?
                              allCharacters[index]
                              :searchCharacters[index]),
                        ));

                  }),
            );






          }else{
            return Center(child: CircularProgressIndicator());
          }

        }

    );
  }
Widget getContentWidget(){
  Provider.of<HomeViewModel>(context, listen: false).getUsers();
  return  Scaffold(
           backgroundColor: ColorManager.white,
    appBar: AppBar(
      backgroundColor: ColorManager.white,
      // title: Text('${AppStrings.tittle}',style: TextStyle(fontSize: FontSize.s18,color: ColorManager.white,fontWeight: FontWeight.w600),),
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: _isSearching
          ? BackButton(
        color: ColorManager.grey,
      )
          : Container(),
      title: _isSearching ? _buildSearchField() : Text('${AppStrings.Search}',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14,),),
      actions: _buildAppBarActions(),

    ),
           body: SafeArea(

             child:SingleChildScrollView(
               controller: _scrollController,

               child: Container(
               width: AppSize.s100.w,
               height: AppSize.s100.h,
               color: ColorManager.white,

               child: RefreshIndicator(
                   onRefresh: ()async {
                     Provider.of<HomeViewModel>(context, listen: false).refresh();

                   },
                   child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         getUsers()
                       ],
                     ),
                   )
               ),
             ),

     ));
}

  static void showMenu(BuildContext context,UserDataEntities repo,
      {bool isLoading = false}) {

    showModalBottomSheet(
      context: context,
      builder: (BuildContext modalContext) {
        return Container(
          width: AppSize.s100.w,
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(AppRadius.r3.w),topRight:Radius.circular(AppRadius.r3.w) )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: AppSize.s100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Container(
                      child:  Text(
                        repo.firstName,
                        style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16.sp),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: (){
                          Navigator.of(modalContext).pop();
                        },
                        icon: Icon(Icons.close,color: ColorManager.grey,size: AppSize.s6.w,),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: AppSize.s100.w,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: AppMargin.m2.w,right: AppMargin.m2.w,top: AppMargin.m2.h),
                      child:  Image.network(repo.avatar,
                        fit: BoxFit.cover,
                        // width: AppSize.s100.w,
                        // height: AppSize.s14.h,
                      ),
                    ),

                   Container(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           margin: EdgeInsets.only(left: AppMargin.m2.w,right: AppMargin.m2.w,top: AppMargin.m2.h),
                           child:Text(
                             "${repo.firstName} ${repo.lastName}",
                             style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16.sp),
                           ),
                         ),
                         Container(
                           margin: EdgeInsets.only(left: AppMargin.m2.w,right: AppMargin.m2.w,top: AppMargin.m2.h),
                           child:Text(
                             repo.email,
                             style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16.sp),
                           ),
                         ),
                       ],
                     ),
                   )
                  ],
                ),
              ),




            ],
          ),
        );
  });}

   @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Responsive(
      desktop: getContentWidget(),
      tablet: getContentWidget(),
      mobile: getContentWidget(),
    );
  }
}
