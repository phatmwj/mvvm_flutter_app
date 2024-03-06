// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryServiceResponse _$CategoryServiceResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryServiceResponse(
      id: json['id'] as int?,
      kind: json['kind'] as int?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CategoryServiceResponseToJson(
        CategoryServiceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'name': instance.name,
      'status': instance.status,
      'image': instance.image,
    };
