import 'package:dio/dio.dart';
import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';

abstract class BaseApiService {
  static final String BASE_URL = "https://ww-user-api.developteam.net/";
  static final String MEDIA_URL = "a";

  Future<dynamic> get(String url, Options options);
  Future<dynamic> post(String url, Map<String, dynamic> data, Options options);
  Future<dynamic> put(String url, Map<String, dynamic> data, Options options);
}
