
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_flutter_app/repo/repository.dart';
import 'package:mvvm_flutter_app/utils/datetime_utils.dart';

import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response/activity_rate.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../di/locator.dart';
import '../../utils/Utils.dart';

class ActivityViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  int ActivityTime = 0;

  String? timeString;

  DateTime currentTime = DateTime.now();

  ResponseWrapper<ActivityRate> activityRes = ResponseWrapper.loading();

  void _setActivity(ResponseWrapper<ActivityRate> Activity){
    activityRes = Activity;
    // notifyListeners();
  }

  void setActivityTime(BuildContext context, int ActivityTime){
    currentTime = DateTime.now();
    this.ActivityTime = ActivityTime;
    statisticActivity(context);
    notifyListeners();
  }

  void doNextTime(BuildContext context){
    if(ActivityTime == 0){
      currentTime = currentTime.add(Duration(days: 1));
    }
    if(ActivityTime == 1){
      currentTime = currentTime.add(Duration(days: 7));
    }
    if(ActivityTime == 2){
      currentTime = DateTime(currentTime.year, currentTime.month + 1, 10);
    }
    statisticActivity(context);
    notifyListeners();
  }

  void doBeforeTime(BuildContext context){
    if(ActivityTime == 0){
      currentTime = currentTime.subtract(Duration(days: 1));
    }
    if(ActivityTime == 1){
      currentTime = currentTime.subtract(Duration(days: 7));
    }
    if(ActivityTime == 2){
      currentTime = DateTime(currentTime.year, currentTime.month - 1, 10);
    }
    statisticActivity(context);
    notifyListeners();
  }

  void statisticActivity(BuildContext context) {
    String startD = '';
    String endD = '';
    if(ActivityTime == 0){
      startD = DatetimeUtils.dateStartFormat(currentTime);
      endD = DatetimeUtils.dateEndFormat(currentTime);
      timeString = DateFormat("dd/MM/yyyy").format(currentTime);
    }
    if(ActivityTime == 1){
      startD = DatetimeUtils.startWeekFormat(currentTime);
      endD = DatetimeUtils.endWeekFormat(currentTime);
      timeString = "Từ ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(startD))} đến ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(endD))}";
    }
    if(ActivityTime == 2){
      startD = DatetimeUtils.startMonthFormat(currentTime);
      endD = DatetimeUtils.endMonthFormat(currentTime);
      timeString = "Từ ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(startD))} đến ${DateFormat("dd/MM/yyyy").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(endD))}";
    }
    // Utils.showLoading();
    // _setActivity(ResponseWrapper.loading());
    _repo
        .activityRate(DatetimeUtils.convertToUTC(startD), DatetimeUtils.convertToUTC(endD))
        .then((value) {
      _setActivity(ResponseWrapper.completed(value));
      notifyListeners();
      // Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      // Utils.dismissLoading();
      _setActivity(ResponseWrapper.error(error.toString()));
    })
        .whenComplete((){
      // Utils.dismissLoading();
    });
  }
}