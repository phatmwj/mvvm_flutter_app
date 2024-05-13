class ActivityRate {
  int totalBookingAccept;
  int totalBookingCancel;
  int totalBookingSuccess;

  ActivityRate({
    required this.totalBookingAccept,
    required this.totalBookingCancel,
    required this.totalBookingSuccess,
  });

  factory ActivityRate.fromJson(Map<String, dynamic> json) {
    return ActivityRate(
      totalBookingAccept: json['totalBookingAccept'] as int,
      totalBookingCancel: json['totalBookingCancel'] as int,
      totalBookingSuccess: json['totalBookingSuccess'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalBookingAccept'] = this.totalBookingAccept;
    data['totalBookingCancel'] = this.totalBookingCancel;
    data['totalBookingSuccess'] = this.totalBookingSuccess;
    return data;
  }
}
