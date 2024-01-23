import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter_app/data/model/api/ResponseWrapper.dart';
import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';
import 'package:mvvm_flutter_app/data/model/api/response/LoginResponse.dart';
import 'package:mvvm_flutter_app/data/remote/AppException.dart';
import 'package:mvvm_flutter_app/data/remote/network/AuthInterceptor.dart';
import 'package:mvvm_flutter_app/data/remote/network/BaseApiService.dart';

class NetworkApiService extends BaseApiService {

  Dio createDio() {
    final dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    return dio;
  }

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    final dio = createDio();
    try {
      final response = await dio.get(BaseApiService.BASE_URL + url);
      responseJson = returnResponse(response.data);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future post(String url, LoginRequest loginRequest) async {
    Options options = Options(
      headers: {
        'IgnoreAuth': '1', // Thêm header tùy chỉnh
      },
    );
    dynamic responseJson;
    final dio = createDio();
    try {
      dynamic response = await dio.post(BaseApiService.BASE_URL + url,options: options, data: loginRequest.toMap());
      // ResponseWrapper<LoginResponse> res = ResponseWrapper.fromJson(response.data, (data)=>LoginResponse.fromJson(data));
      // responseJson = returnResponse(response.data);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.toString());
      case 404:
        throw UnauthorisedException(response.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}