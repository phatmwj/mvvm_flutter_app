import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response_list_wrapper.dart';

import '../../data/local/prefs/prefereces_service_impl.dart';
import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';
import '../../utils/datetime_utils.dart';
import '../../utils/utils.dart';

class IncomeDetailsViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  List<HistoryResponse> _histories = [];

  bool isRefresh = false;

  bool isLazyLoad = false;

  int _totalElements = 0;

  int _page = 0;
  int _size = 10;


  int get page => _page;

  setPage(int value) {
    _page = value;
    notifyListeners();
  }

  int get size => _size;

  setSize(int value) {
    _size = value;
    notifyListeners();
  }

  setTotalElement(int totalElements){
    _totalElements = totalElements;
    notifyListeners();
  }

  int get totalElements => _totalElements;

  ResponseWrapper<ResponseListWrapper<HistoryResponse>> res = ResponseWrapper.loading();

  List<HistoryResponse> get histories => _histories;


  setListHistory(List<HistoryResponse> histories){
    _histories.addAll(histories);
    notifyListeners();
  }


  refreshListHistory(){
    _histories.clear();
  }

  void _setRes(ResponseWrapper<ResponseListWrapper<HistoryResponse>> res){
    this.res = res;
  }

  Future<void> getHistory(String? endD, String? startD) async{

    if(!isLazyLoad){
      _setRes(ResponseWrapper.loading());
    }
    _repo
        .getHistory(DatetimeUtils.convertToUTC(endD!), DatetimeUtils.convertToUTC(startD!), page, size, 300)
        .then((value) {
      if(value.result!){
        final List<HistoryResponse>? data = value.data?.content?.map((e) => e).toList();

        setTotalElement(value.data!.totalElements!);
        log("page $page");
        setPage(page + 1);
        log("total $totalElements");

        setListHistory(data as List<HistoryResponse>);

        _setRes(ResponseWrapper.completed(value));

      }
      notifyListeners();
    })
        .onError((error, stackTrace) {
      log(error.toString());
      if(!isLazyLoad){
        _setRes(ResponseWrapper.error(error.toString()));
      }
    })
        .whenComplete((){
      notifyListeners();
      isLazyLoad = false;
    });
  }


}