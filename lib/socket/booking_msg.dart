class BookingMsg {
  String? codeBooking;

  BookingMsg(this.codeBooking);

  factory BookingMsg.fromJson(Map<String, dynamic> json) {
    return BookingMsg(
      json['codeBooking'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (codeBooking != null) data['codeBooking'] = codeBooking;
    return data;
  }
}
