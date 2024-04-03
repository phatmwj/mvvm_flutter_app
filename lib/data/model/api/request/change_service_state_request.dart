class ChangeServiceStateRequest {
  final int? driverServiceId;
  final int? newState;

  ChangeServiceStateRequest(this.driverServiceId, this.newState);

  // factory ChangeServiceStateRequest.fromJson(Map<String, dynamic> json) {
  //   return ChangeServiceStateRequest(
  //     driverServiceId: json['driverServiceId'],
  //     newState: json['newState'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverServiceId'] = this.driverServiceId;
    data['newState'] = this.newState;
    return data;
  }
}
