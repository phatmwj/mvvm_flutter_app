
import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/data/model/api/response/current_booking.dart';

import '../../../data/local/prefs/preferences_service.dart';
import '../../../data/model/api/response_wrapper.dart';
import '../../../di/locator.dart';
import '../../../repo/repository.dart';

class HistoryDetailViewModel extends ChangeNotifier {

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  bool isRefresh = false;

  ResponseWrapper<CurrentBooking> res = ResponseWrapper.loading();

  _setRes(ResponseWrapper<CurrentBooking> res) {
    this.res = res;
    if(isRefresh){
      notifyListeners();
    }
  }

  Future<void> getBooking(int? id) async {
    _setRes(ResponseWrapper.loading());
    _repo
        .getBooking(id)
        .then((value) => {
                _setRes(ResponseWrapper.completed(value)),
            })
        .onError((error, stackTrace) =>
            {_setRes(ResponseWrapper.error(error.toString())),
    })
        .whenComplete(() => {
        notifyListeners(),
        isRefresh = false,
    });
  }
}
