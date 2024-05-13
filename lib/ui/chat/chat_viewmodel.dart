import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../../constant/constant.dart';
import '../../data/local/prefs/prefereces_service_impl.dart';
import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response/chat_message.dart';
import '../../data/model/api/response/room_response.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';
import '../../socket/command.dart';
import '../../socket/message.dart';

class ChatViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  String? msg;

  String? codeBooking;

  int? userId;

  // List<ChatResponse> _histories = [];

  bool isRefresh = false;

  bool isLazyLoad = false;

  Future<String> sendMessage(String codeBooking) async {
    String? token = await _prefs.getToken();
    ChatMessage chatMessage = ChatMessage(codeBooking: codeBooking, messageId: DateTime.now().millisecondsSinceEpoch.toString(), message: msg);
    Message message = Message(Constant.APP_NAME, "1.0", Command.CM_SEND_MESSAGE,chatMessage.toJson().toString() ,"vi", 0, 35000, token);
    return message.toJson().toString();
  }

  void setMsg(String? msgs){
    msg = msgs;
  }

  ResponseWrapper<RoomResponse> res = ResponseWrapper.loading();
  //
  // List<ChatResponse> get histories => _histories;
  //
  //
  // setListChat(List<ChatResponse> histories){
  //   _histories.addAll(histories);
  //   notifyListeners();
  // }


  // refreshListChat(){
  //   _histories.clear();
  // }
  //
  void _setRes(ResponseWrapper<RoomResponse> res){
    this.res = res;
  }

  Future<void> getRoom(String? roomId) async{
    userId = await _prefs.getDriverId();
    if(!isLazyLoad){
      _setRes(ResponseWrapper.loading());
    }
    _repo
        .getChatRoom(roomId)
        .then((value) {
      if(value.result!){
        _setRes(ResponseWrapper.completed(value));

      }
      notifyListeners();
    })
        .onError((error, stackTrace) {
      log(error.toString());
    })
        .whenComplete((){
      notifyListeners();
    });
  }

  Future<void> getRoom2(String? roomId) async{
    userId = await _prefs.getDriverId();
    _repo
        .getChatRoom(roomId)
        .then((value) {
      if(value.result!){
        _setRes(ResponseWrapper.completed(value));

      }
      notifyListeners();
    })
        .onError((error, stackTrace) {
      log(error.toString());
    })
        .whenComplete((){
      notifyListeners();
    });
  }



}