class UpdateBookingRequest {
  int? id;
  String? note;
  int? state;

  UpdateBookingRequest(this.id, this.note, this.state);

  // factory UpdateBookingRequest.fromJson(Map<String, dynamic> json) {
  //   return UpdateBookingRequest(
  //     id: json['id'],
  //     note: json['note'],
  //     state: json['state'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'note': note,
      'state': state,
    };
    return data;
  }
}
