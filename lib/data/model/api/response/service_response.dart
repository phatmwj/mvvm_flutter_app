

import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_flutter_app/data/model/api/response/category_service_response.dart';
part 'service_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceResponse{
  int id;
  int kind;
  String name;
  String description;
  String price;
  String image;
  CategoryServiceResponse category;

  ServiceResponse(this.id, this.kind, this.name, this.description, this.price,
      this.image, this.category);

  factory ServiceResponse.fromJson(Map<String, dynamic> data) => _$ServiceResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}