import 'package:flutter/cupertino.dart';

import '../../data/model/api/response/profile_response.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../repo/repository.dart';
import '../../utils/Utils.dart';

class AccountPageViewModel extends ChangeNotifier {

  final _repo = Repository();

  ResponseWrapper<ProfileResponse> profileRes = ResponseWrapper.loading();

  void _setProfileRes(ResponseWrapper<ProfileResponse> res){
    profileRes = res;
    // notifyListeners();
  }

  void getProfile(BuildContext context){
    _setProfileRes(ResponseWrapper.loading());
    Utils.showLoading();
    _repo
        .getProfile()
        .then((value) {
      _setProfileRes(ResponseWrapper.completed(value));
      notifyListeners();
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