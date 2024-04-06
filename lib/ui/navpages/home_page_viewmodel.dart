
import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/data/model/api/response_wrapper.dart';
import 'package:mvvm_flutter_app/data/model/api/request/cancel_booking_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/event_booking_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/state_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/update_booking_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/current_booking.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/service_online_response.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';

import '../../constant/constant.dart';
import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/request/position_request.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';

class HomePageViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  int bookingState = Constant.BOOKING_NONE;

  ResponseWrapper<ProfileResponse> profileRes = ResponseWrapper.loading();

  ResponseWrapper<ServiceOnlineResponse> serviceOnline = ResponseWrapper.loading();

  ResponseWrapper<CurrentBooking> bookingRes = ResponseWrapper.loading();

  LocationData? _currentLocation;

  LocationData? _destinationLocation;

  int _driverState = 0;

  int get driverState => _driverState;
  
  // void setStateBooking(int value){
  //   bookingState = value;
  //   // notifyListeners();
  // }

  LocationData? get currentLocation => _currentLocation;
  void setCurrentLocation(LocationData loc){
    _currentLocation = loc;
    notifyListeners();
  }

  LocationData? get destinationLocation => _destinationLocation;
  void setDestinationLocation(LocationData loc){
    _destinationLocation = loc;
    notifyListeners();
  }

  void setNullDestinationLocation(){
    _destinationLocation = null;
  }

  void setDriverState(int value) {
    _driverState = value;
  }

  void _setProfileRes(ResponseWrapper<ProfileResponse> res){
    profileRes = res;
  }

  void _setServiceOnline(ResponseWrapper<ServiceOnlineResponse> serviceOnline){
    this.serviceOnline = serviceOnline;
  }

  void _setBooking(ResponseWrapper<CurrentBooking> booking){
    bookingRes = booking;
  }


  Future<void> getProfile(BuildContext context)async {
    _setProfileRes(ResponseWrapper.loading());
    // Utils.showLoading();
    _repo
        .getProfile()
        .then((value) {
      _setProfileRes(ResponseWrapper.completed(value));
      _prefs.setDriverId(profileRes.data!.id!);
      // Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      _setProfileRes(ResponseWrapper.error(profileRes.message));
      // Utils.dismissLoading();
    })
        .whenComplete((){
      // Utils.dismissLoading();
    });
  }

  Future<void> getServiceOnline(BuildContext context)async {
    _setServiceOnline(ResponseWrapper.loading());
    // Utils.showLoading();
    _repo
        .getDriverState()
        .then((value) {
      _setServiceOnline(ResponseWrapper.completed(value));
      setDriverState(serviceOnline.data!.driverState);
      log(" driver state $_driverState");
      // Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      _setProfileRes(ResponseWrapper.error(serviceOnline.message));
      // Utils.dismissLoading();
    })
        .whenComplete((){
      // Utils.dismissLoading();
    });
  }

  void updatePosition(BuildContext context){
    DateTime timeUpdate = DateTime.now().toUtc();
    String timeUpdateString = DateFormat('dd/MM/yyyy HH:mm:ss', 'en_US').format(timeUpdate);
    PositionRequest request  = PositionRequest(isBusy: 0, latitude: currentLocation!.latitude.toString(), longitude:currentLocation!.longitude.toString() , status: 1, timeUpdate: timeUpdateString);
    _repo
        .updatePosition(request)
        .then((value) {
          // Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
    });
  }

  Future<void> changeDriverState(BuildContext context)async {
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

  Future<void> getCurrentBooking(BuildContext context)async {
    _setBooking(ResponseWrapper.loading());
    // Utils.showLoading();
    _repo
        .getCurrentBooking()
        .then((value) {
      _setBooking(ResponseWrapper.completed(value));
      // Utils.dismissLoading();
      if(bookingRes.data?.state == Constant.BOOKING_STATE_DRIVER_ACCEPT){
        bookingState = Constant.BOOKING_ACCEPTED;
        setDestinationLocation(LocationData.fromMap({
          "latitude": bookingRes.data!.pickupLat,
          "longitude": bookingRes.data!.pickupLong,
        }));
      } else if(bookingRes.data?.state == Constant.BOOKING_STATE_PICKUP_SUCCESS) {
        bookingState = Constant.BOOKING_PICKUP;
        setDestinationLocation(LocationData.fromMap({
          "latitude": bookingRes.data!.destinationLat,
          "longitude": bookingRes.data!.destinationLong,
        }));
      }
    })
        .onError((error, stackTrace) {
      _setProfileRes(ResponseWrapper.error(bookingRes.message));
      // Utils.dismissLoading();
    })
        .whenComplete((){
      // Utils.dismissLoading();
    });
  }

  Future<void> loadBooking(BuildContext context, String bookingId)async {
    _setBooking(ResponseWrapper.loading());
    Utils.showLoading();
    _repo
        .loadBookingById(bookingId)
        .then((value) {
      _setBooking(ResponseWrapper.completed(value));
      setDestinationLocation(LocationData.fromMap({
        "latitude": bookingRes.data!.pickupLat,
        "longitude": bookingRes.data!.pickupLong,
      }));
      bookingState = Constant.BOOKING_VISIBLE;
      notifyListeners();
      Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      _setProfileRes(ResponseWrapper.error(bookingRes.message));
      Utils.dismissLoading();
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  Future<void> rejectBooking(BuildContext context)async {
    CancelBookingRequest request = CancelBookingRequest(null, bookingRes.data!.id);
    Utils.showLoading();
    _repo
        .rejectBooking(request)
        .then((value) {
          bookingState = Constant.BOOKING_CANCELED;
          _destinationLocation = null;
          notifyListeners();
      Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
          Utils.dismissLoading();
    });
  }

  Future<void> updateStateBooking(BuildContext context, int state)async {
    UpdateBookingRequest request = UpdateBookingRequest(bookingRes.data?.id, null, state);
    Utils.showLoading();
    _repo
        .updateStateBooking(request)
        .then((value) {
      if(state == Constant.BOOKING_STATE_PICKUP_SUCCESS){
        bookingState = Constant.BOOKING_PICKUP;
        setDestinationLocation(LocationData.fromMap({
          "latitude": bookingRes.data!.destinationLat,
          "longitude": bookingRes.data!.destinationLong,
        }));
      }else if(state == Constant.BOOKING_STATE_DONE){
        bookingState = Constant.BOOKING_SUCCESS;
        _destinationLocation = null;
      }
      notifyListeners();
      Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  Future<void> acceptBooking(BuildContext context)async {
    EventBookingRequest request = EventBookingRequest(bookingRes.data?.id, null);
    Utils.showLoading();
    _repo
        .acceptBooking(request)
        .then((value) {
        bookingState = Constant.BOOKING_ACCEPTED;
        notifyListeners();

      Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  Future<void> cancelBooking(BuildContext context)async {
    CancelBookingRequest request = CancelBookingRequest(null, bookingRes.data!.id);
    Utils.showLoading();
    _repo
        .cancelBooking(request)
        .then((value) {
      bookingState = Constant.BOOKING_CANCELED;
      _destinationLocation = null;
      notifyListeners();
      Utils.toastSuccessMessage(value.message);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }
}