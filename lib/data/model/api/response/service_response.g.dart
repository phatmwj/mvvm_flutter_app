// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponse _$ServiceResponseFromJson(Map<String, dynamic> json) =>
    ServiceResponse(
      json['id'] as int?,
      json['kind'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['price'] as String?,
      json['image'] as String?,
      json['category'] == null
          ? null
          : CategoryServiceResponse.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceResponseToJson(ServiceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'category': instance.category?.toJson(),
    };
