import 'package:mvvm_flutter_app/data/model/api/request/LoginRequest.dart';

abstract class BaseApiService {
  static final String BASE_URL = "https://ww-user-api.developteam.net/";
  static final String MEDIA_URL = "a";

  Future<dynamic> getResponse(String url, dynamic data);
  Future<dynamic> post(String url, dynamic data);
}
