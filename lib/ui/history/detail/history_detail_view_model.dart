import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/data/model/api/ResponseWrapper.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/repository/Repository.dart';

class HistoryDetailViewModel extends ChangeNotifier {
  final _repo = Repository();

  ResponseWrapper<HistoryResponse> res = ResponseWrapper.loading();

  setRes(ResponseWrapper<HistoryResponse> res) {
    this.res = res;
    notifyListeners();
  }

  Future<void> getHistoryDetail(int id) async {
    _repo.getHistoryDetail(id).then((value) {
      if (value.result!) {
        setRes(ResponseWrapper.completed(value));
      }
    }).onError((error, stackTrace) {
      log(error.toString());
      setRes(ResponseWrapper.error(error.toString()));
    }).whenComplete(() {});
  }
}
