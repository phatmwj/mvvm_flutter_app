
import 'package:flutter/foundation.dart';

class LoginRequest{
  String password;
  String phone;

  LoginRequest({required this.phone, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> data) => LoginRequest(
      password: data['password'],
      phone: data['phone']);

  Map<String, dynamic> toMap() =>{
    'password': password,
    'phone': phone
  };

}