// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) =>
    HistoryResponse(
      json['id'] as int?,
      json['driver'] == null
          ? null
          : ProfileResponse.fromJson(json['driver'] as Map<String, dynamic>),
      json['code'] as String?,
      json['status'] as String?,
      json['createdDate'] as String?,
      json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      json['service'] == null
          ? null
          : ServiceResponse.fromJson(json['service'] as Map<String, dynamic>),
      json['state'] as int?,
      json['destinationAddress'] as String?,
      json['pickupAddress'] as String?,
      (json['money'] as num?)?.toDouble(),
      (json['promotionMoney'] as num?)?.toDouble(),
      json['ratioShare'] as int?,
      (json['bookingDetails'] as List<dynamic>?)
          ?.map(
              (e) => BookingDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['rating'] == null
          ? null
          : RatingResponse.fromJson(json['rating'] as Map<String, dynamic>),
      (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driver': instance.driver?.toJson(),
      'code': instance.code,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'customer': instance.customer?.toJson(),
      'service': instance.service?.toJson(),
      'state': instance.state,
      'destinationAddress': instance.destinationAddress,
      'pickupAddress': instance.pickupAddress,
      'money': instance.money,
      'promotionMoney': instance.promotionMoney,
      'ratioShare': instance.ratioShare,
      'bookingDetails':
          instance.bookingDetails?.map((e) => e.toJson()).toList(),
      'rating': instance.rating?.toJson(),
      'distance': instance.distance,
    };
