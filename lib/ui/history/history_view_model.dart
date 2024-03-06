import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response_list_wrapper.dart';

import '../../data/local/prefs/AppPreferecesService.dart';
import '../../data/model/api/ResponseWrapper.dart';
import '../../repository/Repository.dart';
import '../../utils/Utils.dart';

class HistoryViewModel extends ChangeNotifier{
  final _repo = Repository();
  final _prefs = AppPreferencesService();

  List<HistoryResponse> _histories = [];

  bool isLoading = false;

  ResponseWrapper<ResponseListWrapper<HistoryResponse>> res = ResponseWrapper.loading();

  List<HistoryResponse> get histories => _histories;

  HistoryViewModel(){
    getHistory();
  }
  setListHistory(List<HistoryResponse> histories){
    _histories = histories;
  }


  void _showLoading(bool loading){
    isLoading = loading;
    notifyListeners();
  }

  void _setLoginRes(ResponseWrapper<ResponseListWrapper<HistoryResponse>> res){
    this.res = res;
    notifyListeners();
  }

  Future<void> getHistory() async{
    Utils.showLoading();

    _setLoginRes(ResponseWrapper.loading());
    _repo
        .getHistory(null, null, 0, 10, null)
        .then((value) {
      _showLoading(false);
      Utils.dismissLoading();
      if(value.result!){
        final List<HistoryResponse>? data = value.data?.content?.map((e) => e).toList();

        setListHistory(data as List<HistoryResponse>);

        Utils.toastSuccessMessage("Đăng nhập thành công");
        _setLoginRes(ResponseWrapper.completed(value));

      }else{
        Utils.toastErrorMessage("Tên đăng nhập hoặc mật khẩu không đúng");
        print(" alo $value");
      }
    })
        .onError((error, stackTrace) {
      Utils.dismissLoading();
      log(error.toString());
      _showLoading(false);
      _setLoginRes(ResponseWrapper.error(error.toString()));})
        .whenComplete((){
      Utils.dismissLoading();
      _showLoading(false);
    });
  }
}