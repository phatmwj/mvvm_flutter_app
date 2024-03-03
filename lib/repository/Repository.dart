
import 'dart:developer';

import 'package:mvvm_flutter_app/data/model/api/ApiResponse.dart';
import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';
import 'package:mvvm_flutter_app/data/model/api/response/LoginResponse.dart';
import 'package:mvvm_flutter_app/data/remote/network/BaseApiService.dart';
import 'package:mvvm_flutter_app/data/remote/network/NetworkApiService.dart';

import '../data/model/api/ResponseWrapper.dart';
import '../data/remote/network/ApiEndPoints.dart';

class Repository{

  final BaseApiService _apiService = NetworkApiService();

  Future<ResponseWrapper<LoginResponse>> login(LoginRequest loginRequest) async{
    try{
      dynamic res = await _apiService.getResponse(ApiEndPoints.USER_LOGIN, loginRequest);
      final jsonData = ResponseWrapper<LoginResponse>.fromJson(res,(p0) => LoginResponse.fromJson(res['data']));
      log("data login ${jsonData.toMap()}");
      return jsonData;
    }catch(e){
      throw e;
    }
  }
}