
class RegisterResponse{
  late String data;

  RegisterResponse({required this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> data) => RegisterResponse(data: data['data']);

  Map<String, dynamic> toJson() => {
    'data' : data
  };

}