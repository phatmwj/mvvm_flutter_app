

import 'package:mvvm_flutter_app/data/model/api/response/customer_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';

import 'message_chat.dart';

class RoomResponse {
  final int id;
  final int status;
  final String modifiedDate;
  final String createdDate;
  final String timeStart;
  final List<MessageChat> chatDetails;
  final ProfileResponse driver;
  final CustomerResponse customer;

  RoomResponse({
    required this.id,
    required this.status,
    required this.modifiedDate,
    required this.createdDate,
    required this.timeStart,
    required this.chatDetails,
    required this.driver,
    required this.customer,
  });

  factory RoomResponse.fromJson(Map<String, dynamic> json) {
    // Chuyển đổi danh sách chatDetails từ JSON thành List<MessageChat>
    List<MessageChat> chatDetails = [];
    if (json['chatDetails'] != null) {
      json['chatDetails'].forEach((chatDetail) {
        chatDetails.add(MessageChat.fromJson(chatDetail));
      });
    }

    return RoomResponse(
      id: json['id'],
      status: json['status'],
      modifiedDate: json['modifiedDate'],
      createdDate: json['createdDate'],
      timeStart: json['timeStart'],
      chatDetails: chatDetails,
      driver: ProfileResponse.fromJson(json['customer']),
      customer: CustomerResponse.fromJson(json['customer']),
    );
  }
}
