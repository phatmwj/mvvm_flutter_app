// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDetailResponse _$BookingDetailResponseFromJson(
        Map<String, dynamic> json) =>
    BookingDetailResponse(
      json['id'] as int?,
      json['createdDate'] as String?,
      json['state'] as int?,
      json['note'] as String?,
    );

Map<String, dynamic> _$BookingDetailResponseToJson(
        BookingDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'state': instance.state,
      'note': instance.note,
    };
