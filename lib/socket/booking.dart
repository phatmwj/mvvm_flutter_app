class Booking{
  String? codeBooking;

  Booking(this.codeBooking);

  Map<String, dynamic> toMap() =>{
    'codeBooking': codeBooking
  };
}