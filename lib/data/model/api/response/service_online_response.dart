import 'package:mvvm_flutter_app/data/model/api/response/service_online.dart';

class ServiceOnlineResponse {
  late int driverState;
  late List<ServiceOnline> content;
  late int totalElements;
  late int totalPages;

  ServiceOnlineResponse({
    required this.driverState,
    required this.content,
    required this.totalElements,
    required this.totalPages,
  });

  // Named constructor for creating an instance from a map
  ServiceOnlineResponse.fromJson(Map<String, dynamic> json)
      : driverState = json['driverState'],
        content = (json['content'] as List)
            .map((item) => ServiceOnline.fromJson(item))
            .toList(),
        totalElements = json['totalElements'],
        totalPages = json['totalPages'];

  // Map the object to a JSON format
  Map<String, dynamic> toJson() => {
    'driverState': driverState,
    'content': content.map((item) => item.toJson()).toList(),
    'totalElements': totalElements,
    'totalPages': totalPages,
  };
}
