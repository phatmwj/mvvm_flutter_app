

import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_flutter_app/data/model/api/response/booking_detail_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/customer_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/rating_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/service_response.dart';
part 'history_response.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryResponse{
  int id;
  ProfileResponse driver;
  String code;
  String status;
  String createdDate;
  CustomerResponse customer;
  ServiceResponse service;
  int state;
  String destinationAddress;
  String pickupAddress;
  double money;
  double promotionMoney;
  int ratioShare;
  List<BookingDetailResponse> bookingDetails;
  RatingResponse rating;
  double distance;

  HistoryResponse(
      this.id,
      this.driver,
      this.code,
      this.status,
      this.createdDate,
      this.customer,
      this.service,
      this.state,
      this.destinationAddress,
      this.pickupAddress,
      this.money,
      this.promotionMoney,
      this.ratioShare,
      this.bookingDetails,
      this.rating,
      this.distance);

  factory HistoryResponse.fromJson(Map<String, dynamic> data) => _$HistoryResponseFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}