
import 'package:mvvm_flutter_app/data/local/database/User.dart';

class ResponseWrapper<T> {
    bool? result;
    T? data;
    String? message;
    String? code;

    ResponseWrapper({required result, required data, required code, required message});
    
    factory ResponseWrapper.fromJson(Map<String,dynamic> data, T Function(Map<String, dynamic>) fromJsonT)=>ResponseWrapper(
        result:data['result'],
        data: fromJsonT(data['data']),
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