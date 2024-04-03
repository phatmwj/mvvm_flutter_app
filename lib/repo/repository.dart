
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvvm_flutter_app/data/model/api/request/change_service_state_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/login_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/cancel_booking_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/event_booking_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/register_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/state_request.dart';
import 'package:mvvm_flutter_app/data/model/api/request/update_booking_request.dart';
import 'package:mvvm_flutter_app/data/model/api/response/driver_service_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/login_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/current_booking.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/postion_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/profile_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/register_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/service_online_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response_list_wrapper.dart';
import 'package:mvvm_flutter_app/data/remote/network/base_api_service.dart';
import 'package:mvvm_flutter_app/data/remote/network/network_api_service.dart';

import '../data/model/api/response_wrapper.dart';
import '../data/model/api/request/position_request.dart';
import '../data/remote/network/api_end_points.dart';

class Repository{

  final BaseApiService _apiService = NetworkApiService();

  Future<ResponseWrapper<LoginResponse>> login(LoginRequest loginRequest) async{
     Options options = Options(
      headers: {
        'IgnoreAuth': '1',
      }
    );
    try{
      dynamic res = await _apiService.post(ApiEndPoints.USER_LOGIN, loginRequest.toMap(), options);
      final jsonData = ResponseWrapper<LoginResponse>.fromJson(res,(p0) => LoginResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      throw e;
    }
  }

  Future<ResponseWrapper<RegisterResponse>> register(RegisterRequest registerRequest) async{
    Options options = Options(
        headers: {
          'IgnoreAuth': '1',
        }
    );
    try{
      dynamic res = await _apiService.post(ApiEndPoints.USER_REGISTER, registerRequest.toJson(), options);
      final jsonData = ResponseWrapper<RegisterResponse>.fromJson(res,(p0) => RegisterResponse.fromJson(res['data']));
      log("data login ${jsonData.toMap()}");
      return jsonData;
    }catch(e){
      throw e;
    }
  }

  Future<ResponseWrapper<ResponseListWrapper<HistoryResponse>>> getHistory(String? endDate, String? startDate, int? page, int? size, int? state) async{
    Options options = Options(
        headers: {

        }
    );


      dynamic res = await _apiService.get('v1/booking/my-booking?endDate=${endDate ?? ''}&startDate=${startDate ?? ''}&page=$page&size=$size&state=${state ?? ''}', options);
      final jsonData = ResponseWrapper<ResponseListWrapper<HistoryResponse>>.fromJson(res,(p0) => ResponseListWrapper.fromJson(res['data'], (p1) => HistoryResponse.fromJson(p1)));
      log("data login ${jsonData.data?.content}");
      return jsonData;

  }

  Future<ResponseWrapper<ProfileResponse>> getProfile() async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.get(ApiEndPoints.PROFILE, options);
      final jsonData = ResponseWrapper<ProfileResponse>.fromJson(res,(p0) => ProfileResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      throw e;
    }
  }

  Future<ResponseWrapper<ServiceOnlineResponse>> getDriverState() async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.get(ApiEndPoints.DRIVER_STATE, options);
      final jsonData = ResponseWrapper<ServiceOnlineResponse>.fromJson(res,(p0) => ServiceOnlineResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("Error $e");
      throw e;
    }
  }

  Future<ResponseGeneric> updatePosition(PositionRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.UPDATE_POSITION, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("UpdatePosition Error: $e");
      rethrow;
    }
  }

  Future<ResponseGeneric> changeDriverState(DriverStateRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.CHANGE_STATE, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("changeDriverState Error: $e");
      rethrow;
    }
  }

  Future<ResponseWrapper<CurrentBooking>> getCurrentBooking() async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.get(ApiEndPoints.CURRENT_BOOKING, options);
      final jsonData = ResponseWrapper<CurrentBooking>.fromJson(res,(p0) => CurrentBooking.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("getCurrentBooking Error: $e");
      rethrow;
    }
  }

  Future<ResponseWrapper<CurrentBooking>> loadBookingById(String bookingId) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.get("${ApiEndPoints.LOAD_BOOKING_BY_ID}/$bookingId" , options);
      final jsonData = ResponseWrapper<CurrentBooking>.fromJson(res,(p0) => CurrentBooking.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("LoadBooking Error: $e");
      rethrow;
    }
  }

  Future<ResponseGeneric> rejectBooking(CancelBookingRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.REJECT_BOOKING, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("RejectBooking Error: $e");
      rethrow;
    }
  }

  Future<ResponseGeneric> updateStateBooking(UpdateBookingRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.UPDATE_STATE_BOOKING, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("updateStateBooking: $e");
      rethrow;
    }
  }

  Future<ResponseGeneric> acceptBooking(EventBookingRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.ACCEPT_BOOKING, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("acceptBooking: $e");
      rethrow;
    }
  }

  Future<ResponseGeneric> cancelBooking(CancelBookingRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.CANCEL_BOOKING, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("cancelBooking Error: $e");
      rethrow;
    }
  }

  Future<ResponseWrapper<ResponseListWrapper<DriverServiceResponse>>> getDriverService(int? driverId) async{
    Options options = Options(
        headers: {

        }
    );

    try{
      dynamic res = await _apiService.get('${ApiEndPoints.DRIVER_SERVICE}?driverId=$driverId', options);
      final jsonData = ResponseWrapper<ResponseListWrapper<DriverServiceResponse>>.fromJson(res,(p0) => ResponseListWrapper.fromJson(res['data'], (p1) => DriverServiceResponse.fromJson(p1)));
      // log("data login ${jsonData.data?.content}");
      return jsonData;
    }catch(e){
      log("getDriverService: $e");
      rethrow;
    }
  }

  Future<ResponseGeneric> changeServiceState(ChangeServiceStateRequest request) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.put(ApiEndPoints.CHANGE_SERVICE_STATE, request.toJson(), options);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("changeServiceState Error: $e");
      rethrow;
    }
  }
}
