// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRes _$MessageResFromJson(Map<String, dynamic> json) {
  return MessageRes(
    json['cmd'] as String?,
    json['platform'] as int?,
    json['clientVersion'] as String?,
    json['msg'] as String?,
    json['data'] as dynamic?,
    json['token'] as String?,
    json['responseCode'] as int?,
    json['app'] as String?,
  );
}

Map<String, dynamic> _$MessageResToJson(MessageRes instance) =>
    <String, dynamic>{
      'cmd': instance.cmd,
      'platform': instance.platform,
      'clientVersion': instance.clientVersion,
      'msg': instance.msg,
      'data': instance.data,
      'token': instance.token,
      'responseCode': instance.responseCode,
      'app': instance.app,
    };
