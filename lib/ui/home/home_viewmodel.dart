
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/data/local/database/user_dao.dart';
import 'package:mvvm_flutter_app/data/model/api/response_wrapper.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';

import '../../data/local/prefs/AppPreferecesService.dart';
import '../../repo/repository.dart';

class HomeViewModel extends ChangeNotifier{
  final _repo = Repository();

  final _prefs = AppPreferencesService();

  UserDao userDao = UserDao();

  ResponseWrapper<ProfileResponse> profileRes = ResponseWrapper.loading();

  bool _isActive = false;

  bool get isActive => _isActive;

  void setActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  void _setProfileRes(ResponseWrapper<ProfileResponse> res){
    profileRes = res;
    notifyListeners();
  }

  void getProfile(BuildContext context){
    _setProfileRes(ResponseWrapper.loading());
    Utils.showLoading();
    _repo
        .getProfile()
        .then((value) {
          _setProfileRes(ResponseWrapper.completed(value));

            Utils.dismissLoading();
        })
        .onError((error, stackTrace) {
          _setProfileRes(ResponseWrapper.error(profileRes.message));
          Utils.dismissLoading();
        })
        .whenComplete((){
          Utils.dismissLoading();
        });
  }

}