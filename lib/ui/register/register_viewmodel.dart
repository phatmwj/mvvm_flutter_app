
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvvm_flutter_app/data/model/api/request/register_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/register_response.dart';
import 'package:mvvm_flutter_app/ui/login/login_screen.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';

class RegisterViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  late String _fullName;
  late String _phoneNumber;
  late String _password;
  late String _confirmPassword;

  bool isLoading = false;

  ResponseWrapper<RegisterResponse> res = ResponseWrapper.loading();

  void _showLoading(bool loading){
    isLoading = loading;
    notifyListeners();
  }

  String get fullName => _fullName;

  String get phoneNumber => _phoneNumber;

  String get password => _password;

  String get confirmPassword => _confirmPassword;

  setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }


  setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void _setRegisterRes(ResponseWrapper<RegisterResponse> res){
    this.res = res;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async{
    _showLoading(true);
    Utils.showLoading();
    RegisterRequest request = RegisterRequest(fullName: fullName, password: password, phone: phoneNumber);
    _setRegisterRes(ResponseWrapper.loading());

    _repo
        .register(request)
        .then((value) {
          _showLoading(false);
          Utils.dismissLoading();
          if(value.result!){
            Utils.toastSuccessMessage(value.message!);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }else{
            Utils.toastErrorMessage(value.message!);
          }

        })
        .onError((error, stackTrace) {
          _showLoading(false);
          Utils.dismissLoading();
          _setRegisterRes(ResponseWrapper.error(error.toString()));
        })
        .whenComplete((){
      Utils.dismissLoading();
          _showLoading(false);
        });
  }
}