

import 'package:json_annotation/json_annotation.dart';
part 'customer_response.g.dart';

@JsonSerializable()
class CustomerResponse{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? avatar;

  CustomerResponse(this.id, this.name, this.phone, this.email, this.avatar);

  factory CustomerResponse.fromJson(Map<String, dynamic> data) => _$CustomerResponseFromJson(data);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}