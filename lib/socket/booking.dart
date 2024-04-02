class BookingWS{
  String? codeBooking;

  BookingWS(this.codeBooking);

  factory BookingWS.fromJson(Map<String, dynamic> json) {
    return BookingWS(
      json['codeBooking'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codeBooking'] = this.codeBooking;
    return data;
  }
}