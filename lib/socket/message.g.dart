
part of 'message.dart';

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['app'] as String?,
    json['clientVersion'] as String?,
    json['cmd'] as String?,
    json['data'] as String?,
    json['lang'] as String?,
    json['platform'] as int?,
    json['timeout'] as int?,
    json['token'] as String?,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'app': instance.app,
  'clientVersion': instance.clientVersion,
  'cmd': instance.cmd,
  'data': instance.data,
  'lang': instance.lang,
  'platform': instance.platform,
  'timeout': instance.timeout,
  'token': instance.token,
};