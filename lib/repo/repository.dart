
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
import 'package:mvvm_flutter_app/di/locator.dart';

import '../data/model/api/request/income_request.dart';
import '../data/model/api/response/income_response.dart';
import '../data/model/api/response/room_response.dart';
import '../data/model/api/response_wrapper.dart';
import '../data/model/api/request/position_request.dart';
import '../data/remote/network/api_end_points.dart';

abstract class Repository{

  final BaseApiService _apiService = locator<BaseApiService>();

  Future<ResponseWrapper<LoginResponse>> login(LoginRequest loginRequest);

  Future<ResponseWrapper<RegisterResponse>> register(RegisterRequest registerRequest);

  Future<ResponseWrapper<ResponseListWrapper<HistoryResponse>>> getHistory(String? endDate, String? startDate, int? page, int? size, int? state);

  Future<ResponseWrapper<ProfileResponse>> getProfile() ;

  Future<ResponseWrapper<ServiceOnlineResponse>> getDriverState();

  Future<ResponseGeneric> updatePosition(PositionRequest request);

  Future<ResponseGeneric> changeDriverState(DriverStateRequest request);

  Future<ResponseWrapper<CurrentBooking>> getCurrentBooking();

  Future<ResponseWrapper<CurrentBooking>> loadBookingById(String bookingId);

  Future<ResponseGeneric> rejectBooking(CancelBookingRequest request);

  Future<ResponseGeneric> updateStateBooking(UpdateBookingRequest request);

  Future<ResponseWrapper<CurrentBooking>> acceptBooking(EventBookingRequest request);

  Future<ResponseGeneric> cancelBooking(CancelBookingRequest request);

  Future<ResponseWrapper<ResponseListWrapper<DriverServiceResponse>>> getDriverService(int? driverId);

  Future<ResponseGeneric> changeServiceState(ChangeServiceStateRequest request);

  Future<ResponseWrapper<IncomeResponse>> statisticIncome(IncomeRequest request);

  Future<ResponseWrapper<CurrentBooking>> getBooking(int? id);

  Future<ResponseWrapper<RoomResponse>> getChatRoom(String? roomId) ;
}
