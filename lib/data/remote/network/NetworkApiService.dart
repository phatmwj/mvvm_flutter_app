import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';
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
  Future get(String url, Options options) async {
    dynamic responseJson;
    final dio = createDio();
    try {
      Response response = await dio.get(BaseApiService.BASE_URL + url,options: options);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future post(String url, Map<String, dynamic> data, Options options) async {
    dynamic responseJson;
    final dio = createDio();
    try {
      Response response = await dio.post(BaseApiService.BASE_URL + url,options: options, data: data);
      responseJson = returnResponse(response);
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