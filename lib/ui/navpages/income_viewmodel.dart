
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_flutter_app/data/model/api/request/income_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/income_response.dart';
import 'package:mvvm_flutter_app/repo/repository.dart';
import 'package:mvvm_flutter_app/utils/datetime_utils.dart';

import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../di/locator.dart';
import '../../utils/Utils.dart';

class IncomeViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  int incomeTime = 0;

  String? timeString;

  DateTime currentTime = DateTime.now();

  ResponseWrapper<IncomeResponse> incomeRes = ResponseWrapper.loading();

  void _setIncome(ResponseWrapper<IncomeResponse> income){
    incomeRes = income;
    // notifyListeners();
  }

  void setIncomeTime(BuildContext context, int incomeTime){
    currentTime = DateTime.now();
    this.incomeTime = incomeTime;
    statisticIncome(context);
    notifyListeners();
  }

  void doNextTime(BuildContext context){
    if(incomeTime == 0){
      currentTime = currentTime.add(Duration(days: 1));
    }
    if(incomeTime == 1){
      currentTime = currentTime.add(Duration(days: 7));
    }
    if(incomeTime == 2){
      currentTime = DateTime(currentTime.year, currentTime.month + 1, 10);
    }
    statisticIncome(context);
    notifyListeners();
  }

  void doBeforeTime(BuildContext context){
    if(incomeTime == 0){
      currentTime = currentTime.subtract(Duration(days: 1));
    }
    if(incomeTime == 1){
      currentTime = currentTime.subtract(Duration(days: 7));
    }
    if(incomeTime == 2){
      currentTime = DateTime(currentTime.year, currentTime.month - 1, 10);
    }
    statisticIncome(context);
    notifyListeners();
  }

  void statisticIncome(BuildContext context) {
    String startD = '';
    String endD = '';
    if(incomeTime == 0){
      startD = DatetimeUtils.dateStartFormat(currentTime);
      endD = DatetimeUtils.dateEndFormat(currentTime);
      timeString = DateFormat("dd/MM/yyyy").format(currentTime);
    }
    if(incomeTime == 1){
      startD = DatetimeUtils.startWeekFormat(currentTime);
      endD = DatetimeUtils.endWeekFormat(currentTime);
      timeString = "Từ ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(startD))} đến ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(endD))}";
    }
    if(incomeTime == 2){
      startD = DatetimeUtils.startMonthFormat(currentTime);
      endD = DatetimeUtils.endMonthFormat(currentTime);
      timeString = "Từ ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(startD))} đến ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(endD))}";
    }
    Utils.showLoading();
    // _setIncome(ResponseWrapper.loading());
    IncomeRequest request = IncomeRequest(bookingState: 300, startDate: DatetimeUtils.convertToUTC(startD), endDate: DatetimeUtils.convertToUTC(endD));
    _repo
        .statisticIncome(request)
        .then((value) {
          _setIncome(ResponseWrapper.completed(value));
          notifyListeners();
          Utils.dismissLoading();
        })
        .onError((error, stackTrace) {
          Utils.dismissLoading();
          _setIncome(ResponseWrapper.error(error.toString()));
        })
        .whenComplete((){
          Utils.dismissLoading();
        });
  }
}