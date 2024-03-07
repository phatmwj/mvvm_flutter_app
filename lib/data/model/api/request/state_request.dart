
class DriverStateRequest {
  int newState;

  DriverStateRequest({
    required this.newState,
  });

  // Named constructor for creating an instance from a map
  DriverStateRequest.fromJson(Map<String, dynamic> json)
      : newState = json['newState'];

  // Map the object to a JSON format
  Map<String, dynamic> toJson() => {
    'newState': newState,
  };
}
