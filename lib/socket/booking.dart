class BookingWS{
  List<String>? codeBooking;

  BookingWS(this.codeBooking);

  factory BookingWS.fromJson(Map<String, dynamic> json) {
    // Chú ý kiểm tra null trước khi truy cập thuộc tính trong json
    return BookingWS(
      json['codeBooking'] != null ? List<String>.from(json['codeBooking']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codeBooking'] = this.codeBooking;
    return data;
  }
}