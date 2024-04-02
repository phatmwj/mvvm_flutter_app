

class CancelBookingRequest {
  String? note;
  int? id;

  CancelBookingRequest(this.note, this.id);

  // factory CancelBookingRequest.fromJson(Map<String, dynamic> json) {
  //   return CancelBookingRequest(
  //     note: json['note'] as String?,
  //     id: json['id'] as int?,
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'note': note,
      'id': id,
    };
    return data;
  }
}
