

import 'dart:developer';

import 'package:mvvm_flutter_app/data/model/api/response/booking_detail_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/customer_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/rating_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/room.dart';
import 'package:mvvm_flutter_app/data/model/api/response/service_response.dart';

class CurrentBooking {
  int? id;
  int? status;
  String? modifiedDate;
  String? createdDate;
  ProfileResponse? driver;
  CustomerResponse? customer;
  ServiceResponse? service;
  Room? room;
  String? code;
  int? state;
  String? pickupAddress;
  double? pickupLat;
  double? pickupLong;
  String? destinationAddress;
  double? destinationLat;
  double? destinationLong;
  double? distance;
  double? money;
  double? promotionMoney;
  List<BookingDetailResponse>? bookingDetails;
  String? note;
  String? customerNote;
  RatingResponse? rating;

  CurrentBooking(this.id,
        this.status,
        this.modifiedDate,
        this.createdDate,
        this.driver,
        this.customer,
        this.service,
        this.room,
        this.code,
        this.state,
        this.pickupAddress,
        this.pickupLat,
        this.pickupLong,
        this.destinationAddress,
        this.destinationLat,
        this.destinationLong,
        this.distance,
        this.money,
        this.promotionMoney,
        this.bookingDetails,
        this.note,
        this.customerNote,
        this.rating);

  // CurrentBooking.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   status = json['status'];
  //   modifiedDate = json['modifiedDate'];
  //   createdDate = json['createdDate'];
  //   driver = json['driver']== null? null: ProfileResponse.fromJson(json['driver']);
  //   customer = json['customer']==null? null: CustomerResponse.fromJson(json['customer']);
  //   service = json['service']==null? null:ServiceResponse.fromJson(json['service']);
  //   room = json['room']==null? null:Room.fromJson(json['room']);
  //   code = json['code'];
  //   state = json['state'];
  //   pickupAddress = json['pickupAddress'];
  //   pickupLat = json['pickupLat'];
  //   pickupLong = json['pickupLong'];
  //   destinationAddress = json['destinationAddress'];
  //   destinationLat = json['destinationLat'];
  //   destinationLong = json['destinationLong'];
  //   distance = json['distance'];
  //   money = json['money'];
  //   promotionMoney = json['promotionMoney'];
  //   if (json['bookingDetails'] != null) {
  //     bookingDetails = <BookingDetailResponse>[];
  //     json['bookingDetails'].forEach((v) {
  //       bookingDetails?.add(BookingDetailResponse.fromJson(v));
  //     });
  //   }
  //   note = json['note'];
  //   customerNote = json['customerNote'];
  //   rating = json['rating']==null? null: RatingResponse.fromJson(json['rating']);
  // }

  CurrentBooking.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?; // Kiểm tra và ép kiểu
      // status = json['status'] as int?; // Kiểm tra và ép kiểu
      modifiedDate = json['modifiedDate'] as String?;
      createdDate = json['createdDate'] as String?;
      driver =
      json['driver'] == null ? null : ProfileResponse.fromJson(json['driver']);
      customer = json['customer'] == null ? null : CustomerResponse.fromJson(
          json['customer']);
      service = json['service'] == null ? null : ServiceResponse.fromJson(
          json['service']);
      room = json['room'] == null ? null : Room.fromJson(json['room']);
      code = json['code'] as String?;
      state = json['state'] as int?; // Kiểm tra và ép kiểu
      pickupAddress = json['pickupAddress'] as String?;
      pickupLat = json['pickupLat'] as double?; // Kiểm tra và ép kiểu
      pickupLong = json['pickupLong'] as double?; // Kiểm tra và ép kiểu
      destinationAddress = json['destinationAddress'] as String?;
      destinationLat = json['destinationLat'] as double?; // Kiểm tra và ép kiểu
      destinationLong =
      json['destinationLong'] as double?; // Kiểm tra và ép kiểu
      distance = json['distance'] as double?; // Kiểm tra và ép kiểu
      money = json['money'] as double?; // Kiểm tra và ép kiểu
      promotionMoney = json['promotionMoney'] as double?; // Kiểm tra và ép kiểu
      if (json['bookingDetails'] != null) {
        bookingDetails = <BookingDetailResponse>[];
        json['bookingDetails'].forEach((v) {
          bookingDetails?.add(BookingDetailResponse.fromJson(v));
        });
      }
      note = json['note'] as String?;
      customerNote = json['customerNote'] as String?;
      rating =
      json['rating'] == null ? null : RatingResponse.fromJson(json['rating']);
    }catch(e){
      log("loi $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['modifiedDate'] = modifiedDate;
    data['createdDate'] = createdDate;
    data['driver'] = driver?.toJson();
    data['customer'] = customer?.toJson();
    data['service'] = service?.toJson();
    data['room'] = room?.toJson();
    data['code'] = code;
    data['state'] = state;
    data['pickupAddress'] = pickupAddress;
    data['pickupLat'] = pickupLat;
    data['pickupLong'] = pickupLong;
    data['destinationAddress'] = destinationAddress;
    data['destinationLat'] = destinationLat;
    data['destinationLong'] = destinationLong;
    data['distance'] = distance;
    data['money'] = money;
    data['promotionMoney'] = promotionMoney;
    if (bookingDetails!.isNotEmpty) {
      data['bookingDetails'] =
          bookingDetails?.map((v) => v.toJson()).toList();
    }
    data['note'] = note;
    data['customerNote'] = customerNote;
    data['rating'] = rating?.toJson();
    return data;
  }
}
