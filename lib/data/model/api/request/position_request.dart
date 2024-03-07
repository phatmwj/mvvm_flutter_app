
class PositionRequest {
  int isBusy;
  String latitude;
  String longitude;
  int status;
  String timeUpdate;

  PositionRequest({
    required this.isBusy,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.timeUpdate,
  });

  PositionRequest.fromJson(Map<String, dynamic> json)
      : isBusy = json['isBusy'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        status = json['status'],
        timeUpdate = json['timeUpdate'];

  Map<String, dynamic> toJson() => {
    'isBusy': isBusy,
    'latitude': latitude,
    'longitude': longitude,
    'status': status,
    'timeUpdate': timeUpdate,
  };
}
