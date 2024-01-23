
import 'dart:ffi';

class LoginResponse{
  String? access_token;
  String? refresh_token;
  String? token_type;
  Long? user_id;
  int? user_kind;

  LoginResponse({required access_token, required refresh_token, required token_type, required user_id, required user_kind});

  factory LoginResponse.fromJson(Map<String, dynamic> data)=>LoginResponse(
      access_token: data['access_token'],
      refresh_token: data['refresh_token'],
      token_type: data['token_type'],
      user_id: data['user_id'],
      user_kind: data['user_kind']
  );

  Map<String, dynamic> toMap()=>{
    'access_token': access_token,
    'refresh_token':refresh_token,
    'token_type': token_type,
    'user_id': user_id,
    'user_kind': user_kind
  };

  @override
  String toString() {
    return 'LoginResponse{access_token: $access_token, refresh_token: $refresh_token, token_type: $token_type, user_id: $user_id, user_kind: $user_kind}';
  }
}