

class ResponseGeneric {
  String message;
  bool result;

  ResponseGeneric({
    required this.message,
    required this.result,
  });

  // Named constructor for creating an instance from a map
  ResponseGeneric.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        result = json['result'];

  // Map the object to a JSON format
  Map<String, dynamic> toJson() => {
    'message': message,
    'result': result,
  };
}
