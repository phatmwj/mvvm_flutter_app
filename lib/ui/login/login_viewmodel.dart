import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvvm_flutter_app/data/local/prefs/prefereces_service_impl.dart';
import 'package:mvvm_flutter_app/data/model/api/api_response.dart';
import 'package:mvvm_flutter_app/data/model/api/request/login_request.dart';
import 'package:mvvm_flutter_app/ui/home/home_screen.dart';
import 'package:mvvm_flutter_app/ui/widget/loading_widget.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';

import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../data/model/api/response/login_response.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';

class LoginViewModel extends ChangeNotifier {

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  late String _phoneNumber;
  late String _password;

  String get phoneNumber => _phoneNumber;
  String get password => _password;

  ResponseWrapper<LoginResponse> res = ResponseWrapper.loading();

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void _setLoginRes(ResponseWrapper<LoginResponse> res){
      this.res = res;
      notifyListeners();
  }

// Thêm các phương thức xử lý đăng nhập, kiểm tra hợp lệ, v.v.
  Future<void> loginUser(BuildContext context) async {
    Utils.showLoading();
    LoginRequest loginRequest = LoginRequest(phone: _phoneNumber, password: _password);
    dynamic j = loginRequest.toMap();
    final a = LoginRequest.fromJson(j);
    print(a.toMap());
    _setLoginRes(ResponseWrapper.loading());
    _repo
        .login(loginRequest)
        .then((value) {
          Utils.dismissLoading();
         if(value.result!){
           Utils.toastSuccessMessage("Đăng nhập thành công");
           _setLoginRes(ResponseWrapper.completed(value));
           String? token = value.data?.access_token;
           _prefs.setToken(token!);
           print("token nef $token");
           // Utils.dismissLoading();
           Navigator.pushReplacementNamed(context, HomeScreen.id);

         }else{
           Utils.toastErrorMessage("Tên đăng nhập hoặc mật khẩu không đúng");
         }
        })
        .onError((error, stackTrace) {
      // Utils.dismissLoading();
          _setLoginRes(ResponseWrapper.error(error.toString()));})
        .whenComplete((){
      Utils.dismissLoading();
    });
  }
}