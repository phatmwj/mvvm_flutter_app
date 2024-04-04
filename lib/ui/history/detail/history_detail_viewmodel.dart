
import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/data/model/api/response/current_booking.dart';

import '../../../data/model/api/response_wrapper.dart';
import '../../../repo/repository.dart';

class HistoryDetailViewModel extends ChangeNotifier {
  final _repo = Repository();

  ResponseWrapper<CurrentBooking> res = ResponseWrapper.loading();

  _setRes(ResponseWrapper<CurrentBooking> res) {
    this.res = res;
  }

  void getBooking(int? id) {
    _setRes(ResponseWrapper.loading());

    _repo
        .getBooking(id)
        .then((value) => {
                _setRes(ResponseWrapper.completed(value)),
                notifyListeners(),
            })
        .onError((error, stackTrace) =>
            {_setRes(ResponseWrapper.error(error.toString()))})
        .whenComplete(() => {});
  }
}