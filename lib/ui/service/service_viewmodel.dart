
import 'package:flutter/widgets.dart';
import 'package:mvvm_flutter_app/data/model/api/request/change_service_state_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/driver_service_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response_list_wrapper.dart';

import '../../data/local/prefs/prefereces_service_impl.dart';
import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/response_wrapper.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';
import '../../utils/Utils.dart';

class ServiceViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();
  
  ResponseWrapper<ResponseListWrapper<DriverServiceResponse>> service = ResponseWrapper.loading();
  
  void _setService(ResponseWrapper<ResponseListWrapper<DriverServiceResponse>> service){
    this.service = service;
    notifyListeners();
  }

  Future<void> getService(BuildContext context) async {
    int? driverId = await _prefs.getDriverId();
    _setService(ResponseWrapper.loading());
    Utils.showLoading();
    _repo
        .getDriverService(driverId)
        .then((value) {
      _setService(ResponseWrapper.completed(value));
      Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      _setService(ResponseWrapper.error(service.message));
      Utils.dismissLoading();
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  Future<void> changeServiceState(BuildContext context, int newState, int serviceId) async {
    int? driverId = await _prefs.getDriverId();
    ChangeServiceStateRequest request = ChangeServiceStateRequest(serviceId, newState);
    _repo
        .changeServiceState(request)
        .then((value) {
          Utils.toastSuccessMessage(value.message);
          _repo
              .getDriverService(driverId)
              .then((value2) {
            _setService(ResponseWrapper.completed(value2));
          })
              .onError((error, stackTrace) {
          })
              .whenComplete((){
          });
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
    });
  }

}