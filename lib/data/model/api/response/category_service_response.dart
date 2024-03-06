

import 'package:json_annotation/json_annotation.dart';
part 'category_service_response.g.dart';

@JsonSerializable()
class CategoryServiceResponse{
  int? id;
  int? kind;
  String? name;
  int? status;
  String? image;

  CategoryServiceResponse(
      {required this.id, required this.kind, required this.name, required this.status, required this.image});

  factory CategoryServiceResponse.fromJson(Map<String, dynamic> data) => _$CategoryServiceResponseFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryServiceResponseToJson(this);


}