class EventBookingRequest {
  int? bookingId;
  String? note;

  EventBookingRequest(this.bookingId, this.note);

  // factory EventBookingRequest.fromJson(Map<String, dynamic> json) {
  //   return EventBookingRequest(
  //     bookingId: json['bookingId'],
  //     note: json['note'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'bookingId': bookingId,
      'note': note,
    };
    return data;
  }
}
