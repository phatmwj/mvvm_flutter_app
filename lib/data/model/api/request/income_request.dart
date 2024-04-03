class IncomeRequest {
  int bookingState;
  String startDate;
  String endDate;

  IncomeRequest({required this.bookingState, required this.startDate, required this.endDate});

  factory IncomeRequest.fromJson(Map<String, dynamic> json) {
    return IncomeRequest(
      bookingState: json['bookingState'] as int,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingState'] = bookingState;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
