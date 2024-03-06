
import 'package:json_annotation/json_annotation.dart';
part 'booking_detail_response.g.dart';

@JsonSerializable()
class BookingDetailResponse{
  int? id;
  String? createdDate;
  int? state;
  String? note;

  BookingDetailResponse(this.id, this.createdDate, this.state, this.note);

  factory BookingDetailResponse.fromJson(Map<String, dynamic> data) => _$BookingDetailResponseFromJson(data);

  Map<String, dynamic> toJson() => _$BookingDetailResponseToJson(this);
}