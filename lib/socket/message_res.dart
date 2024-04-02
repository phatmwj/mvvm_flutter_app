
import 'package:json_annotation/json_annotation.dart';
part 'message_res.g.dart';

@JsonSerializable()
class MessageRes{
  String? cmd;
  int? platform;
  String? clientVersion;
  String? msg;
  dynamic? data;
  String? token;
  int? responseCode;
  String? app;

  MessageRes(this.cmd, this.platform, this.clientVersion, this.msg, this.data,
      this.token, this.responseCode, this.app);

  factory MessageRes.fromJson(Map<String, dynamic> json) => _$MessageResFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResToJson(this);
}