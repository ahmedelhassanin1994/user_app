

import 'package:flutter/cupertino.dart';
import 'package:mvvm_project/features/features_home/domain/entities/userentities.dart';
import 'package:mvvm_project/features/features_home/domain/usecase/user_usecase.dart';


enum UsersLoadState {InitialState, loading, loaded, error,loadMore, noData, noMore  }


class HomeViewModel extends ChangeNotifier {

  late UserUseCase userUseCase;
  //users state
  UsersLoadState _stateUsers = UsersLoadState.InitialState;
  UsersLoadState get stateUsers => _stateUsers;

  final _perPage = 6;
  int _page =1;
  List<UserDataEntities> users=[];
  bool _isEnd = false;
  bool isLoading = false;
  bool get isEnd => _isEnd;

  HomeViewModel(this.userUseCase);


  Future<void> refresh()async {
    _stateUsers = UsersLoadState.InitialState;
    _page = 0;
    notifyListeners();
    getUsers();

  }

  Future<void> getUsers()async {
    if (_stateUsers == UsersLoadState.InitialState) {
      _stateUsers=UsersLoadState.loading;
      notifyListeners();
    (await userUseCase.execute(InputUseCase(_page.toString(),_perPage.toString()))).fold((
          l) =>
      {
        _stateUsers=UsersLoadState.error,
        notifyListeners(),
      }, (r) =>
      {
        users.clear(),
        users.addAll(r.data),
        _stateUsers=UsersLoadState.loaded,

        notifyListeners(),
      });
    }
  }

  Future<void>getUsersLoadMore()async {
    if (_stateUsers == UsersLoadState.loaded) {
      _page++;
      _stateUsers = UsersLoadState.loadMore;
      _isEnd = true;
      isLoading=true;
      notifyListeners();
      (await userUseCase.execute(InputUseCase("${_page}","$_perPage"))).fold((
          l) =>
      {
        _stateUsers = UsersLoadState.error,
        isLoading=false,
        notifyListeners(),
      }, (r) =>
      {

        if(r.data.length<6){
          _stateUsers = UsersLoadState.noMore,
          users.addAll(r.data),
          isLoading = false,
          notifyListeners(),
        }else if(r.data.isEmpty){
          _stateUsers = UsersLoadState.noMore,
          isLoading = false,
          notifyListeners(),
        } else {


          users.addAll(r.data),
          _stateUsers = UsersLoadState.loaded,
          isLoading = false,
          notifyListeners(),
        }});
    }
  }

}