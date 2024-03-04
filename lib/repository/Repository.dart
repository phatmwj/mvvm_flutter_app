
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';
import 'package:mvvm_flutter_app/data/model/api/request/register_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/LoginResponse.dart';
import 'package:mvvm_flutter_app/data/model/api/response/register_response.dart';
import 'package:mvvm_flutter_app/data/remote/network/BaseApiService.dart';
import 'package:mvvm_flutter_app/data/remote/network/NetworkApiService.dart';

import '../data/model/api/ResponseWrapper.dart';
import '../data/remote/network/ApiEndPoints.dart';

class Repository{

  final BaseApiService _apiService = NetworkApiService();

  Future<ResponseWrapper<LoginResponse>> login(LoginRequest loginRequest) async{
     Options options = Options(
      headers: {
        'IgnoreAuth': '1',
      }
    );
    try{
      dynamic res = await _apiService.post(ApiEndPoints.USER_LOGIN, loginRequest.toMap(), options);
      final jsonData = ResponseWrapper<LoginResponse>.fromJson(res,(p0) => LoginResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      throw e;
    }
  }

  // Future<ResponseWrapper<RegisterResponse>> register(RegisterRequest registerRequest) async{
  //   try{
  //     dynamic res = await _apiService.getResponse(ApiEndPoints.USER_REGISTER, registerRequest);
  //     final jsonData = ResponseWrapper<LoginResponse>.fromJson(res,(p0) => LoginResponse.fromJson(res['data']));
  //     log("data login ${jsonData.toMap()}");
  //     return jsonData;
  //   }catch(e){
  //     throw e;
  //   }
  // }
}