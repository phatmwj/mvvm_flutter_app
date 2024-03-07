import 'package:mvvm_flutter_app/data/model/api/response/service_response.dart';

class ServiceOnline {
  int id;
  int state;
  int status;
  ServiceResponse service;

  ServiceOnline({
    required this.id,
    required this.state,
    required this.status,
    required this.service,
  });

  // Named constructor for creating an instance from a map
  ServiceOnline.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        state = json['state'],
        status = json['status'],
        service = ServiceResponse.fromJson(json['service']);

  // Map the object to a JSON format
  Map<String, dynamic> toJson() => {
    'id': id,
    'state': state,
    'status': status,
    'service': service.toJson(),
  };
}
