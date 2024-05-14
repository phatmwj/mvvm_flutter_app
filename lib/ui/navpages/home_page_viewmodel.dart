
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
import 'package:mvvm_flutter_app/socket/web_socket_viewmodel.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';

import '../../constant/constant.dart';
import '../../data/local/prefs/preferences_service.dart';
import '../../data/model/api/request/position_request.dart';
import '../../di/locator.dart';
import '../../repo/repository.dart';
import '../../socket/booking.dart';
import '../../socket/booking_msg.dart';

class HomePageViewModel extends ChangeNotifier{

  final _repo = locator<Repository>();

  final _prefs = locator<PreferencesService>();

  int bookingState = Constant.BOOKING_NONE;

  ResponseWrapper<ProfileResponse> profileRes = ResponseWrapper.loading();

  ResponseWrapper<ServiceOnlineResponse> serviceOnline = ResponseWrapper.loading();

  CurrentBooking? bookingRes;

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

  void _setBooking(CurrentBooking booking){
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

  Future<void> getCurrentBooking(BuildContext context, WebSocketViewModel wsvm)async {
    // _setBooking(ResponseWrapper.loading());
    // Utils.showLoading();
    _repo
        .getCurrentBooking()
        .then((value) {
      _setBooking(value.data!.content!.first!);
      wsvm.booking = BookingWS([bookingRes!.code!]);
      wsvm.bookingMsg = BookingMsg(bookingRes!.code!);
      // Utils.dismissLoading();
      if(bookingRes?.state == Constant.BOOKING_STATE_DRIVER_ACCEPT){
        bookingState = Constant.BOOKING_ACCEPTED;
        setDestinationLocation(LocationData.fromMap({
          "latitude": bookingRes?.pickupLat,
          "longitude": bookingRes?.pickupLong,
        }));
      } else if(bookingRes?.state == Constant.BOOKING_STATE_PICKUP_SUCCESS) {
        bookingState = Constant.BOOKING_PICKUP;
        setDestinationLocation(LocationData.fromMap({
          "latitude": bookingRes?.destinationLat,
          "longitude": bookingRes?.destinationLong,
        }));
      }
    })
        .onError((error, stackTrace) {
      // Utils.dismissLoading();
    })
        .whenComplete((){
      // Utils.dismissLoading();
    });
  }

  Future<void> loadBooking(BuildContext context, String bookingId)async {
    Utils.showLoading();
    _repo
        .loadBookingById(bookingId)
        .then((value) {
      _setBooking(value.data!);
      setDestinationLocation(LocationData.fromMap({
        "latitude": bookingRes?.pickupLat,
        "longitude": bookingRes?.pickupLong,
      }));
      bookingState = Constant.BOOKING_VISIBLE;
      notifyListeners();
      Utils.dismissLoading();
    })
        .onError((error, stackTrace) {
      // _setProfileRes(ResponseWrapper.error(bookingRes.message));
      Utils.dismissLoading();
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  Future<void> rejectBooking(BuildContext context)async {
    CancelBookingRequest request = CancelBookingRequest(null, bookingRes?.id);
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
    UpdateBookingRequest request = UpdateBookingRequest(bookingRes?.id, null, state);
    Utils.showLoading();
    _repo
        .updateStateBooking(request)
        .then((value) {
      if(state == Constant.BOOKING_STATE_PICKUP_SUCCESS){
        bookingState = Constant.BOOKING_PICKUP;
        setDestinationLocation(LocationData.fromMap({
          "latitude": bookingRes?.destinationLat,
          "longitude": bookingRes?.destinationLong,
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

  Future<void> acceptBooking(BuildContext context, WebSocketViewModel wsvm)async {
    EventBookingRequest request = EventBookingRequest(bookingRes?.id, null);
    Utils.showLoading();
    _repo
        .acceptBooking(request)
        .then((value) {
        bookingState = Constant.BOOKING_ACCEPTED;
        _setBooking(value.data!);
        wsvm.roomId = bookingRes?.room!.id!;
        notifyListeners();

      Utils.toastSuccessMessage(value.message!);
    })
        .onError((error, stackTrace) {
    })
        .whenComplete((){
      Utils.dismissLoading();
    });
  }

  Future<void> cancelBooking(BuildContext context)async {
    CancelBookingRequest request = CancelBookingRequest(null, bookingRes?.id);
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