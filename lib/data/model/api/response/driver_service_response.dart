import 'profile_response.dart'; // Import các lớp cần thiết
import 'service_response.dart';
import 'dart:convert';

class DriverServiceResponse {
  int? id;
  int? ratioShare;
  int? state;
  int? status;
  ProfileResponse? driver;
  ServiceResponse? service;

  DriverServiceResponse({
    required this.id,
    required this.ratioShare,
    required this.state,
    required this.status,
    required this.driver,
    required this.service,
  });

  factory DriverServiceResponse.fromJson(Map<String, dynamic> json) {
    return DriverServiceResponse(
      id: json['id'],
      ratioShare: json['ratioShare'],
      state: json['state'],
      status: json['status'],
      driver: json['driver'] != null ? ProfileResponse.fromJson(json['driver']) : null,
      service: json['service'] != null ? ServiceResponse.fromJson(json['service']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['ratioShare'] = ratioShare;
    data['state'] = state;
    data['status'] = status;
    data['driver'] = driver?.toJson();
    data['service'] = service?.toJson();
    return data;
  }
}
