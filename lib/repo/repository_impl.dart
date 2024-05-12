
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
import 'package:mvvm_flutter_app/data/model/api/response/room_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response/service_online_response.dart';
import 'package:mvvm_flutter_app/data/model/api/response_list_wrapper.dart';
import 'package:mvvm_flutter_app/data/remote/network/base_api_service.dart';
import 'package:mvvm_flutter_app/data/remote/network/network_api_service.dart';
import 'package:mvvm_flutter_app/di/locator.dart';
import 'package:mvvm_flutter_app/repo/repository.dart';

import '../data/model/api/request/income_request.dart';
import '../data/model/api/response/income_response.dart';
import '../data/model/api/response_wrapper.dart';
import '../data/model/api/request/position_request.dart';
import '../data/remote/network/api_end_points.dart';

class RepositoryImpl extends Repository{

  final BaseApiService _apiService = locator<BaseApiService>();

  @override
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

  @override
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

  @override
  Future<ResponseWrapper<ResponseListWrapper<HistoryResponse>>> getHistory(String? endDate, String? startDate, int? page, int? size, int? state) async{

    dynamic res = await _apiService.get('v1/booking/my-booking?endDate=${endDate ?? ''}&startDate=${startDate ?? ''}&page=$page&size=$size&state=${state ?? ''}', null);
    final jsonData = ResponseWrapper<ResponseListWrapper<HistoryResponse>>.fromJson(res,(p0) => ResponseListWrapper.fromJson(res['data'], (p1) => HistoryResponse.fromJson(p1)));
    log("data login ${jsonData.data?.content}");
    return jsonData;

  }

  @override
  Future<ResponseWrapper<ProfileResponse>> getProfile() async {
    try{
      dynamic res = await _apiService.get(ApiEndPoints.PROFILE, null);
      final jsonData = ResponseWrapper<ProfileResponse>.fromJson(res,(p0) => ProfileResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      throw e;
    }
  }

  @override
  Future<ResponseWrapper<ServiceOnlineResponse>> getDriverState() async {
    try{
      dynamic res = await _apiService.get(ApiEndPoints.DRIVER_STATE, null);
      final jsonData = ResponseWrapper<ServiceOnlineResponse>.fromJson(res,(p0) => ServiceOnlineResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("Error $e");
      throw e;
    }
  }

  @override
  Future<ResponseGeneric> updatePosition(PositionRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.UPDATE_POSITION, request.toJson(), null);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("UpdatePosition Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseGeneric> changeDriverState(DriverStateRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.CHANGE_STATE, request.toJson(), null);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("changeDriverState Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<CurrentBooking>> getCurrentBooking() async {
    try{
      dynamic res = await _apiService.get(ApiEndPoints.CURRENT_BOOKING, null);
      final jsonData = ResponseWrapper<CurrentBooking>.fromJson(res,(p0) => CurrentBooking.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("getCurrentBooking Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<CurrentBooking>> loadBookingById(String bookingId) async {
    try{
      dynamic res = await _apiService.get("${ApiEndPoints.LOAD_BOOKING_BY_ID}/$bookingId" , null);
      final jsonData = ResponseWrapper<CurrentBooking>.fromJson(res,(p0) => CurrentBooking.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("LoadBooking Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseGeneric> rejectBooking(CancelBookingRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.REJECT_BOOKING, request.toJson(), null);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("RejectBooking Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseGeneric> updateStateBooking(UpdateBookingRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.UPDATE_STATE_BOOKING, request.toJson(), null);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("updateStateBooking: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<CurrentBooking>> acceptBooking(EventBookingRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.ACCEPT_BOOKING, request.toJson(), null);
      final jsonData = ResponseWrapper<CurrentBooking>.fromJson(res,(p0) => CurrentBooking.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("acceptBooking: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseGeneric> cancelBooking(CancelBookingRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.CANCEL_BOOKING, request.toJson(), null);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("cancelBooking Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<ResponseListWrapper<DriverServiceResponse>>> getDriverService(int? driverId) async{
    try{
      dynamic res = await _apiService.get('${ApiEndPoints.DRIVER_SERVICE}?driverId=$driverId', null);
      final jsonData = ResponseWrapper<ResponseListWrapper<DriverServiceResponse>>.fromJson(res,(p0) => ResponseListWrapper.fromJson(res['data'], (p1) => DriverServiceResponse.fromJson(p1)));
      // log("data login ${jsonData.data?.content}");
      return jsonData;
    }catch(e){
      log("getDriverService: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseGeneric> changeServiceState(ChangeServiceStateRequest request) async {
    try{
      dynamic res = await _apiService.put(ApiEndPoints.CHANGE_SERVICE_STATE, request.toJson(), null);
      final jsonData = ResponseGeneric.fromJson(res);
      return jsonData;
    }catch(e){
      log("changeServiceState Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<IncomeResponse>> statisticIncome(IncomeRequest request) async{
    try{
      dynamic res = await _apiService.post(ApiEndPoints.STATISTIC_INCOME, request.toJson(), null);
      final jsonData = ResponseWrapper<IncomeResponse>.fromJson(res,(p0) => IncomeResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("statisticIncome Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<CurrentBooking>> getBooking(int? id) async {
    try{
      dynamic res = await _apiService.get('${ApiEndPoints.BOOKING_DETAIL}/$id', null);
      final jsonData = ResponseWrapper<CurrentBooking>.fromJson(res, (p0) => CurrentBooking.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("getBooking Error: $e");
      rethrow;
    }
  }

  @override
  Future<ResponseWrapper<RoomResponse>> getChatRoom(String? roomId) async {
    Options options = Options(
        headers: {
        }
    );
    try{
      dynamic res = await _apiService.get('${ApiEndPoints.GET_ROOM_CHAT}/${roomId!}', options);
      final jsonData = ResponseWrapper<RoomResponse>.fromJson(res,(p0) => RoomResponse.fromJson(res['data']));
      return jsonData;
    }catch(e){
      log("getChatRoom $e");
      throw e;
    }
  }
}
