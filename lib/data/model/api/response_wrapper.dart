
import 'package:mvvm_flutter_app/data/local/database/user.dart';

import 'api_status.dart';

class ResponseWrapper<T> {
    bool? result;
    T? data;
    String? message;
    String? code;
    ApiStatus? status;

    ResponseWrapper.loading() : status = ApiStatus.LOADING;

    ResponseWrapper.completed(ResponseWrapper<T> completedResponse)
        : status = ApiStatus.COMPLETED,
            result = completedResponse.result,
            data = completedResponse.data,
            message = completedResponse.message,
            code = completedResponse.code;

    ResponseWrapper.error(this.message) : status = ApiStatus.ERROR;

    ResponseWrapper({required this.result, required this.data, required this.code, required this.message});
    
    factory ResponseWrapper.fromJson(Map<String,dynamic> data, T Function(Map<String, dynamic>) fromJsonT)=>ResponseWrapper(
        result:data['result'],
        data:data['data'] == null? null : fromJsonT(data['data']),
        message:data['message'],
        code:data['code']);

    Map<String, dynamic> toMap() =>{
        'result':result,
        'data':data,
        'message': message,
        'code': code
    };

    @override
    String toString() {
    return 'ResponseWrapper{result: $result, data: $data, message: $message, code: $code}';
  }
}