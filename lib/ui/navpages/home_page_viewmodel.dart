
import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/data/model/api/ResponseWrapper.dart';
import 'package:mvvm_flutter_app/data/model/api/request/state_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/service_online_response.dart';
import 'package:mvvm_flutter_app/utils/Utils.dart';

import '../../data/local/prefs/AppPreferecesService.dart';
import '../../data/model/api/request/position_request.dart';
import '../../repository/Repository.dart';

class HomePageViewModel extends ChangeNotifier{
  final _repo = Repository();

  final _prefs = AppPreferencesService();

  String avatar = '';

  ResponseWrapper<ProfileResponse> profileRes = ResponseWrapper.loading();

  ResponseWrapper<ServiceOnlineResponse> serviceOnline = ResponseWrapper.loading();

  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  LocationData? _currentLocation;

  LocationData? get currentLocation => _currentLocation;

  bool _isActive = false;

  int _driverState = 0;

  int get driverState => _driverState;

  bool get isActive => _isActive;

  void setActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  void setCurrentLocation(LocationData loc){
    _currentLocation = loc;
    notifyListeners();
  }

  void setDriverState(int value) {
    _driverState = value;
    notifyListeners();
  }

  void _setProfileRes(ResponseWrapper<ProfileResponse> res){
    profileRes = res;
    notifyListeners();
  }

  void _setServiceOnline(ResponseWrapper<ServiceOnlineResponse> serviceOnline){
    this.serviceOnline = serviceOnline;
    notifyListeners();
  }


  void getProfile(BuildContext context){
    _setProfileRes(ResponseWrapper.loading());
    Utils.showLoading();
    _repo
        .getProfile()
        .then((value) {
      _setProfileRes(ResponseWrapper.completed(value));
      avatar = (profileRes.data != null ? profileRes.data?.avatar :'')!;
      Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      _setProfileRes(ResponseWrapper.error(profileRes.message));
      Utils.dismissLoading();
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  void getServiceOnline(BuildContext context){
    _setServiceOnline(ResponseWrapper.loading());
    Utils.showLoading();
    _repo
        .getDriverState()
        .then((value) {
      _setServiceOnline(ResponseWrapper.completed(value));
      setDriverState(serviceOnline.data!.driverState);
      log(" driver state $_driverState");
      Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      _setProfileRes(ResponseWrapper.error(serviceOnline.message));
      Utils.dismissLoading();
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  void updatePosition(BuildContext context){
    DateTime timeUpdate = DateTime.now().toUtc();
    String timeUpdateString = DateFormat('dd/MM/yyyy HH:mm:ss', 'en_US').format(timeUpdate);
    PositionRequest request  = PositionRequest(isBusy: 0, latitude: _currentLocation!.latitude.toString(), longitude:_currentLocation!.longitude.toString() , status: 1, timeUpdate: timeUpdateString);
    _repo
        .updatePosition(request)
        .then((value) {
          Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
    });
  }

  void changeDriverState(BuildContext context){
    DriverStateRequest request = DriverStateRequest(newState: _driverState);
    _repo
        .changeDriverState(request)
        .then((value) {
      Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
    });
  }
}