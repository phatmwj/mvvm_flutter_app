
class RegisterRequest {
  late String fullName;
  late String password;
  late String phone;

  RegisterRequest({required this.fullName, required this.password, required this.phone});

  factory RegisterRequest.fromJson(Map<String, dynamic> data) => RegisterRequest(
      fullName : data['fullName'],
      password : data['password'],
      phone : data['phone']);


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['password'] = password;
    map['phone'] = phone;
    return map;
  }

}