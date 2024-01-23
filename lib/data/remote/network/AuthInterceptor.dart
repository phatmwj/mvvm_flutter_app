

import 'package:dio/dio.dart';
import 'package:mvvm_flutter_app/data/local/prefs/AppPreferecesService.dart';
import 'package:mvvm_flutter_app/data/local/prefs/PreferencesService.dart';
import 'package:mvvm_flutter_app/data/remote/network/BaseApiService.dart';

class AuthInterceptor extends Interceptor{

  PreferencesService preferencesService = AppPreferencesService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // logging
    print("--> ${options.method} ${options.uri}");
    print("Headers: ${options.headers}");
    print("Data: ${options.data}");

    String isIgnore = options.headers['IgnoreAuth'];
    if (isIgnore != null && isIgnore == '1') {
      options.headers.remove('IgnoreAuth');
      handler.next(options);
      return;
    }

    // String isSearchLocation = options.headers['isSearchLocation'];
    // if (isSearchLocation != null && isSearchLocation == '1') {
    //   HttpUrl url = options.uri;
    //   String queryNames = url.query;
    //   StringBuffer builder = StringBuffer(BuildConfig.GOOGLE_MAP_URL);
    //   builder.write('/');
    //   for (int i = 0; i < options.pathSegments.length; i++) {
    //     if (i == options.pathSegments.length - 1) {
    //       builder.write('${options.pathSegments[i]}?$queryNames');
    //     } else {
    //       builder.write('${options.pathSegments[i]}/');
    //     }
    //   }
    //   options.headers.remove('isSearchLocation');
    //   options.uri = Uri.parse(builder.toString());
    //   handler.next(options);
    //   return;
    // }



    // Thêm Authentication
    String token = preferencesService.getToken() as String;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }


    String isMediaKind = options.headers['isMedia'];
    if (isMediaKind != null && isMediaKind == '1') {
      StringBuffer builder = StringBuffer(BaseApiService.MEDIA_URL);
      builder.write('/');
      for (String seg in options.uri.pathSegments) {
        builder.write('$seg/');
      }
      options.headers.remove('isMedia');
      options.path = builder.toString();
      handler.next(options);
      return;
    }
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    print("<-- ${err.message}");

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // if (response.statusCode == 403 || response.statusCode == 401) {
      // debugPrint("Error http =====================> code: ${response.statusCode}");
      // appPreferences.removeKey(PreferencesService.KEY_BEARER_TOKEN);
      // Gửi broadcast hoặc thực hiện bất kỳ hành động nào khác khi token hết hạn.
    // }

    print("<-- ${response.statusCode} ${response.requestOptions.uri}");
    print("Headers: ${response.headers}");
    print("Data: ${response.data}");
    handler.next(response);
  }
}