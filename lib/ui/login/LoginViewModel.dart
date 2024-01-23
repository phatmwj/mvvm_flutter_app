import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';

import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';

class LoginViewModel extends ChangeNotifier {
  late String _phoneNumber;
  late String _password;

  String get phoneNumber => _phoneNumber;
  String get password => _password;

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

// Thêm các phương thức xử lý đăng nhập, kiểm tra hợp lệ, v.v.
  Future<void> loginUser() async {
    LoginRequest loginRequest = LoginRequest(phone: _phoneNumber, password: _password);
    BaseApiService apiService = NetworkApiService();
    apiService.post(ApiEndPoints.USER_LOGIN, loginRequest);
  }
}