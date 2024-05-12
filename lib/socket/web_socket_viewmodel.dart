import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_flutter_app/constant/constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../data/local/prefs/prefereces_service_impl.dart';
import '../data/local/prefs/preferences_service.dart';
import 'booking.dart';
import 'booking_msg.dart';
import 'command.dart';
import 'message.dart';
import 'message_res.dart';

class WebSocketViewModel extends ChangeNotifier {
  late WebSocketChannel _channel;
  // List<String> messages = [];
  late Message message;
  late Timer _pingTimer;
  MessageRes? messageRes;

  BookingWS booking = BookingWS(["9xsjej","exampleCode1","exampleCode2"]);

  BookingMsg bookingMsg = BookingMsg("9xsjej");

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool isConnected = false;

  WebSocketViewModel(){
    _init();
    // _initConnectivity();
  }


  void _init(){
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
        isConnected = false;
        _pingTimer.cancel();
        if (!isConnected) {
          Future.delayed(Duration(seconds: 1), () {
            log('WebSocket reconnect');
            _init();// Trigger StreamBuilder rebuild
          });
        }
      },
      onError: (error) {
        log('WebSocket error: $error');
        _pingTimer.cancel();
        isConnected = false;
        if (!isConnected) {
          Future.delayed(Duration(seconds: 1), () {
            log('WebSocket reconnect');
            _init();// Trigger StreamBuilder rebuild
          });
        }
      },
      cancelOnError: true,
    );

    isConnected = true;
    sendClientInfo();

    _pingTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      sendPing();
    });
  }

  void _initConnectivity() {
    // Lắng nghe sự kiện thay đổi trạng thái kết nối mạng
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        if(_channel != null || _channel.closeCode == null){
          closeWebSocket();
        }
        // closeWebSocket();
        log("network_connect");
        // Có kết nối mạng, kiểm tra và kết nối lại WebSocket
        if (_channel == null || _channel.closeCode != null) {
          _init();
        }
        // _init();
      }else{
        log("network_error");
        closeWebSocket();
      }
    });
  }

  Future<void> sendClientInfo() async {
    PreferencesService _pref = PreferencesServiceImpl();
    String? token = await _pref.getToken();
    Message message = Message(Constant.APP_NAME, "1.0", Command.COMMAND_CLIENT_INFO,booking.toJson().toString() ,"vi", 0, 35000, token);
    _channel.sink.add(message.toJson().toString());
    log(message.toJson().toString());
  }

  Future<void> sendPing() async {
    PreferencesService _pref = PreferencesServiceImpl();
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
    _pingTimer.cancel();
    _channel.sink.close();
  }

  @override
  void dispose() {
    closeWebSocket();
    super.dispose();
  }
}
