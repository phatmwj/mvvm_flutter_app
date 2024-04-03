class IncomeResponse {
  late int driverId;
  late double totalMoney;
  late double totalBookingMoney;
  late int totalBookingCancel;

  IncomeResponse({
    required this.driverId,
    required this.totalMoney,
    required this.totalBookingMoney,
    required this.totalBookingCancel,
  });

  IncomeResponse.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    totalMoney = json['totalMoney'];
    totalBookingMoney = json['totalBookingMoney'];
    totalBookingCancel = json['totalBookingCancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driverId'] = driverId;
    data['totalMoney'] = totalMoney;
    data['totalBookingMoney'] = totalBookingMoney;
    data['totalBookingCancel'] = totalBookingCancel;
    return data;
  }
}
