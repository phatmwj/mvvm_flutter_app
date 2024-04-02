import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mvvm_flutter_app/constant/Constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../data/local/prefs/AppPreferecesService.dart';
import '../data/local/prefs/PreferencesService.dart';
import 'booking.dart';
import 'command.dart';
import 'message.dart';
import 'message_res.dart';

class WebSocketViewModel extends ChangeNotifier {
  late WebSocketChannel _channel;
  // List<String> messages = [];
  late Message message;
  late Timer _pingTimer;
  MessageRes? messageRes;

  BookingWS booking = BookingWS("0");

  WebSocketViewModel() {
    _channel = WebSocketChannel.connect(
      Uri.parse(Constant.WSS_URL),
    );

    _channel.stream.listen(
          (data) {
            log('Received data: $data');
            Map<String, dynamic> jsonDataMap = jsonDecode(data);
            messageRes= MessageRes.fromJson(jsonDataMap);
            log('CMD SOCKET: ${messageRes?.cmd}');
        notifyListeners();
      },
      onDone: () {
        log('WebSocket closed');
      },
      onError: (error) {
        log('WebSocket error: $error');
      },
    );

    sendClientInfo();

    _pingTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      sendPing();
    });
  }

  Future<void> sendClientInfo() async {
    PreferencesService _pref = AppPreferencesService();
    String? token = await _pref.getToken();
    Message message = Message(Constant.APP_NAME, "1.0", Command.COMMAND_CLIENT_INFO,booking.toJson().toString() ,"vi", 0, 35000, token);
    _channel.sink.add(message.toJson().toString());
    log(message.toJson().toString());
  }

  Future<void> sendPing() async {
    PreferencesService _pref = AppPreferencesService();
    String? token = await _pref.getToken();
    Message message = Message(Constant.APP_NAME, "1.0", Command.COMMAND_PING,booking.toJson().toString() ,"vi", 0, 35000, token);
    _channel.sink.add(message.toJson().toString());
    log(message.toJson().toString());
  }
  // Gửi dữ liệu đến server
  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  // Đóng kết nối WebSocket khi không cần thiết
  void closeWebSocket() {
    _channel.sink.close();
  }

  @override
  void dispose() {
    closeWebSocket();
    super.dispose();
  }
}
