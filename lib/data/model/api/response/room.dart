class Room {
  int? id;
  String? timeStart;

  Room(this.id, this.timeStart);

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeStart = json['timeStart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['timeStart'] = timeStart;
    return data;
  }
}
