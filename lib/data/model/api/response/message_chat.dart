

import 'package:mvvm_flutter_app/data/model/api/response/room.dart';

class MessageChat {
  final int? id;
  final Room? room;
  final int? state;
  final String? msg;
  final String? timeSend;
  final int? sender;
  final int? receiver;
  final String? senderAvatar;

  MessageChat({
    required this.id,
    required this.room,
    required this.state,
    required this.msg,
    required this.timeSend,
    required this.sender,
    required this.receiver,
    required this.senderAvatar,
  });

  factory MessageChat.fromJson(Map<String, dynamic> json) {
    return MessageChat(
      id: json['id'],
      room: Room.fromJson(json['room']),
      state: json['state'],
      msg: json['msg'],
      timeSend: json['timeSend'],
      sender: json['sender'],
      receiver: json['receiver'],
      senderAvatar: json['senderAvatar'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room'] = this.room?.toJson();
    data['state'] = this.state;
    data['msg'] = this.msg;
    data['timeSend'] = this.timeSend;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['senderAvatar'] = this.senderAvatar;
    return data;
  }
}