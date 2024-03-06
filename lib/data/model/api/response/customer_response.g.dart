// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['avatar'] as String?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'avatar': instance.avatar,
    };
