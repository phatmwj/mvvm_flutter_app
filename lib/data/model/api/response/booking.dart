class Booking{
  String? bookingId;

  Booking(this.bookingId);

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      json['bookingId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    return data;
  }
}