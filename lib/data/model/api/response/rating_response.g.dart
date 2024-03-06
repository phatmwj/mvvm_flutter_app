// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingResponse _$RatingResponseFromJson(Map<String, dynamic> json) =>
    RatingResponse(
      json['id'] as int?,
      json['message'] as String?,
      json['star'] as int?,
      json['createdDate'] as String?,
    );

Map<String, dynamic> _$RatingResponseToJson(RatingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'star': instance.star,
      'createdDate': instance.createdDate,
    };
