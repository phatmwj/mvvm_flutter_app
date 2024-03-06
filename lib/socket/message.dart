
import 'package:json_annotation/json_annotation.dart';
part  'message.g.dart';

@JsonSerializable()
class Message{

  String? app;
  String? clientVersion;
  String? cmd;
  String? data;
  String? lang;
  int? platform;
  int? timeout;
  String? token;


  Message(this.app, this.clientVersion, this.cmd, this.data, this.lang,
      this.platform, this.timeout, this.token);

  // Map<String, dynamic> toMap() =>{
  //   'app': app,
  //   'clientVersion': clientVersion,
  //   'cmd':cmd,
  //   'data':data,
  //   'lang':lang,
  //   'platform':platform,
  //   'timeout':timeout,
  //   'token':token
  // };

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}