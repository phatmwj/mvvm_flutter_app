

import 'package:json_annotation/json_annotation.dart';
part 'rating_response.g.dart';

@JsonSerializable()
class RatingResponse{
  int? id;
  String? message;
  int? star;
  String? createdDate;

  RatingResponse(this.id, this.message, this.star, this.createdDate);

  factory RatingResponse.fromJson(Map<String, dynamic> data) => _$RatingResponseFromJson(data);

  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}