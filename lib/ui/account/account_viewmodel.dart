
import 'package:flutter/cupertino.dart';

import '../../data/local/prefs/prefereces_service_impl.dart';
import '../../data/model/api/response/profile_response.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../repo/repository.dart';


class AccountViewModel extends ChangeNotifier{
  final _repo = Repository();

  final _prefs = PreferencesServiceImpl();

  ResponseWrapper<ProfileResponse> res = ResponseWrapper.loading();

  String _name = '';
  String _password = '';

  String get name => _name;
  String get password => _password;

  setName(String name){
    _name = name;
    // notifyListeners();
  }

  setPassword(String password){
    _password = password;
    // notifyListeners();
  }



  setRes(ResponseWrapper<ProfileResponse> res){
    this.res = res;
    // notifyListeners();
  }

  void getProfile(){
    _repo.getProfile()
        .then((value) => {
          if(value.result!){
            setRes(ResponseWrapper.completed(value))
          }else{
              setRes(ResponseWrapper.error(value.message.toString()))
            }
    })
        .onError((error, stackTrace) => {
          setRes(ResponseWrapper.error(error.toString()))
    })
        .whenComplete(() => {
    notifyListeners()
    });

  }
}