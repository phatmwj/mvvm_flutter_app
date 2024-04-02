
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/socket/booking.dart';
import 'package:mvvm_flutter_app/socket/command.dart';
import 'package:mvvm_flutter_app/socket/web_socket_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/navpages/home_page_viewmodel.dart';
import 'package:mvvm_flutter_app/utils/number_utils.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/model/api/response/booking.dart';
import '../../res/colors/app_color.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  late HomePageViewModel vm;
  late WebSocketViewModel wsvm;
  late Future<void> initData;

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Map<PolylineId, Polyline> polylines = {};

  Future<void> getCurrentLocation() async {
    Location location = Location();
    location.getLocation()
        .then((location){
      vm.setCurrentLocation(location);
      vm.updatePosition(context);
      if(vm.destinationLocation != null ){
        getPolylinePoints().then((value) =>{
          generatePolylineFromPoints(value)
        });
      }else {
        polylines.remove(PolylineId("poly"));
      }
    })
    .onError((error, stackTrace){
      log("CurrentLocation Error: $Error");
    });

    final GoogleMapController controller = await _controller.future ;

    location.onLocationChanged.listen((newLoc){
      vm.setCurrentLocation(newLoc);
      // vm.updatePosition(context);
      log("Latitude: ${newLoc.latitude}, Longitude: ${newLoc.longitude}");
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(newLoc.latitude!,newLoc.longitude!),
            zoom: 16),
      ));
      if(vm.destinationLocation != null){
        getPolylinePoints().then((value) =>{
          generatePolylineFromPoints(value)
        });
      }else {
        polylines.remove(PolylineId("poly"));
      }

    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints =  PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(Constant.GG_API_KEY,
        PointLatLng(vm.currentLocation!.latitude!, vm.currentLocation!.longitude!), PointLatLng(vm.destinationLocation!.latitude!, vm.destinationLocation!.longitude!),travelMode: TravelMode.driving);
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) { 
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }else{
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async{
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id ,color: Colors.green,
    points: polylineCoordinates,width: 6);
    polylines[id] = polyline;
  }


  Future<void> fetchInitialData() async {

    // TODO: Fetch your initial data here
    getCurrentLocation();
    vm.getCurrentBooking(context);
    vm.getProfile(context);
    vm.getServiceOnline(context);
  }

  @override
  void initState(){
    vm = Provider.of<HomePageViewModel>(context, listen: false);
    wsvm = Provider.of<WebSocketViewModel>(context, listen: false);
    vm.getCurrentBooking(context);
    vm.getProfile(context);
    vm.getServiceOnline(context);
    getCurrentLocation();

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   getCurrentLocation();
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:

        Consumer<HomePageViewModel>(
          builder: (context,value,_){
            if(vm.destinationLocation != null && vm.currentLocation != null){
              getPolylinePoints().then((value) =>{
                generatePolylineFromPoints(value)
              });
            }else {
              polylines.remove(PolylineId("poly"));
            }
            return vm.currentLocation == null ?
            const Center(child: CircularProgressIndicator(
              color: Color(0xFF7EA567),
              strokeWidth: 6.0,
            ))
                :Stack(
              children:[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(vm.currentLocation!.latitude!, vm.currentLocation!.longitude!),
                    zoom: 16,
                  ),
                  markers:{
                      Marker(
                      markerId: const MarkerId("current location"),
                      position: LatLng(vm.currentLocation!.latitude!, vm.currentLocation!.longitude!),
                    ),
                      vm.destinationLocation != null ?
                        Marker(
                        markerId: const MarkerId("destination location"),
                        position: LatLng(vm.destinationLocation!.latitude!, vm.destinationLocation!.longitude!),
                      ):const Marker(markerId: MarkerId("destination location")),

                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                ),
                Positioned(
                  top: 40.0,
                  left: 16.0,
                  right: 16.0,
                  child: Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: vm.avatar!= null && vm.avatar!=''
                            ? Image.network(Constant.MEDIA_URL+Constant.MEDIA_LOAD_URL+vm.avatar
                              ,width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return const Icon(Icons.error, size: 50.0,); // Replace with your desired error widget
                              },)
                            : const Image(
                              image: AssetImage('assets/images/user_avatar.png'),
                              width: 50.0,
                              height: 50.0,
                             ),
                          ),

                          // const SizedBox(width: 80),
                          Expanded(child: Center(
                            child: Text(
                              vm.driverState != 1? "Offline" : "Online",
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ),
                          ),
                          // const SizedBox(width: 80),

                          SizedBox(
                            height: 35.0,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child:  Switch(
                                      value: vm.driverState != 1? false : true,
                                      activeColor: const Color(0xFF31C548),
                                      onChanged: (bool value) {
                                        value ? vm.setDriverState(1) : vm.setDriverState(0);
                                        vm.changeDriverState(context);
                                        vm.notifyListeners();
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Consumer<WebSocketViewModel>(
                    builder: (context,value,_){
                      if(wsvm.messageRes != null){
                        switch(wsvm.messageRes?.cmd){
                          case Command.CM_CONTACT_DRIVER:
                            Booking booking = Booking.fromJson(wsvm.messageRes?.data);
                            vm.loadBooking(context, booking.bookingId!);
                            wsvm.messageRes = null;
                            break;
                          case Command.CM_CUSTOMER_CANCEL_BOOKING:
                            vm.bookingState = Constant.BOOKING_CUSTOMER_CANCEL;
                            vm.setNullDestinationLocation();
                            // vm.notifyListeners();
                            wsvm.booking = BookingWS("0");
                            wsvm.messageRes = null;
                            break;
                          default:
                            break;
                        }
                      }
                  return Positioned(
                    bottom: 10.0,
                    left: 16.0,
                    right: 16.0,
                    child: vm.bookingState == Constant.BOOKING_NONE ?
                    const SizedBox.shrink():
                    Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Xin chào! Bạn có muốn chở tôi không?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xFF7EA567),
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius:BorderRadius.circular(5.0),
                                  child: vm.bookingRes.data?.customer?.avatar != null && vm.bookingRes.data?.customer?.avatar != ''
                                      ? Image.network(Constant.MEDIA_URL+Constant.MEDIA_LOAD_URL+ vm.bookingRes.data!.customer!.avatar!
                                    ,width: 45.0,
                                    height: 45.0,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return const Icon(Icons.error, size: 50.0,); // Replace with your desired error widget
                                    },)
                                      : const Image(
                                    image: AssetImage('assets/images/user_avatar.png'),
                                    width: 45.0,
                                    height: 45.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(
                                        vm.bookingRes.data?.customer?.name ?? "Tên khách hàng"
                                        ,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Color(0xFF424242),
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      const Text(
                                        "Tiền mặt",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xFF7EA567),
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ]
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children:[
                                        Text(
                                          vm.bookingRes.data?.money != null
                                              ? "${NumberUtils.formatMoneyToString(vm.bookingRes.data!.money!)} đ"
                                              : 'N/A',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color(0xFF424242),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        Text(
                                          vm.bookingRes.data?.distance != null
                                              ? "${(vm.bookingRes.data!.distance!/1000).toStringAsFixed(1)} Km"
                                              : 'N/A',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xFF575757),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ]

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/icon_vector.png'),
                                  height: 20,
                                  width: 20,
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Flexible(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        const Text(
                                          "Điểm đón",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: Color(0xBF424242),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        Text(
                                          vm.bookingRes?.data?.pickupAddress ?? "Địa chỉ đón khách",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFF424242),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ]

                                  ),
                                ),
                              ],

                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/icon_destination.png'),
                                  height: 20,
                                  width: 20,
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Flexible(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        const Text(
                                          "Điểm đến",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: Color(0xBF424242),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        Text(
                                          vm.bookingRes?.data?.destinationAddress ?? "Điểm đến",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFF424242),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ]

                                  ),
                                ),
                              ],

                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            vm.bookingState != Constant.BOOKING_VISIBLE  && vm.bookingState != Constant.BOOKING_CUSTOMER_CANCEL && vm.bookingState != Constant.BOOKING_CANCELED && vm.bookingState != Constant.BOOKING_SUCCESS ? const Divider(
                              color: Color(0xFFC0C0C0),
                            ): const SizedBox.shrink(),
                            vm.bookingState != Constant.BOOKING_VISIBLE  && vm.bookingState != Constant.BOOKING_CUSTOMER_CANCEL && vm.bookingState != Constant.BOOKING_CANCELED && vm.bookingState != Constant.BOOKING_SUCCESS ? const Padding(
                              padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 10.0, right: 10.0),
                              child: Row(
                                  children: [
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Icon(Icons.message_rounded, color: Color(0xFF7EA567),),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Nhắn tin',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xBF424242),
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox()
                                    ),

                                    InkWell(
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone, color: Color(0xFF7EA567),),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Gọi khách hàng',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Color(0xBF424242),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ]
                              ),
                            ):const SizedBox.shrink(),

                            const Divider(
                              color: Color(0xFFC0C0C0),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.note, color: Color(0xCF424242),),

                                const SizedBox(
                                  width: 15,
                                ),

                                Text(
                                  vm.bookingRes.data?.customerNote ?? "Không có ghi chú",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xFF575757),
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],

                            ),
                            vm.bookingState == Constant.BOOKING_VISIBLE ?  const SizedBox(
                              height: 10.0,
                            ): const SizedBox.shrink(),
                            vm.bookingState == Constant.BOOKING_VISIBLE ? Center(child: CircularCountDownTimer(
                              duration: 20,
                              initialDuration: 0,
                              controller: CountDownController(),
                              width: 50.0,
                              height: 50.0,
                              ringColor: Colors.grey[300]!,
                              ringGradient: null,
                              fillColor: const Color(0xFF7EA567),
                              fillGradient: null,
                              backgroundColor: Colors.white,
                              backgroundGradient: null,
                              strokeWidth: 10.0,
                              strokeCap: StrokeCap.round,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color(0xFF7EA567),
                                overflow: TextOverflow.ellipsis
                                ,),
                              textFormat: CountdownTextFormat.S,
                              isReverse: false,
                              isReverseAnimation: false,
                              isTimerTextShown: true,
                              autoStart: true,
                              onStart: () {
                                debugPrint('Countdown Started');
                              },
                              onComplete: () {
                                debugPrint('Countdown Ended');
                                vm.rejectBooking(context);
                              },
                              onChange: (String timeStamp) {
                                debugPrint('Countdown Changed $timeStamp');
                              },
                              timeFormatterFunction: (defaultFormatterFunction, duration) {
                                if (duration.inSeconds == 0) {
                                  return "0";
                                } else {
                                  return Function.apply(defaultFormatterFunction, [duration]);
                                }
                              },
                            ),) : const SizedBox.shrink(),

                            const SizedBox(
                              height: 10.0,
                            ),

                            vm.bookingState != Constant.BOOKING_CUSTOMER_CANCEL && vm.bookingState != Constant.BOOKING_CANCELED && vm.bookingState != Constant.BOOKING_SUCCESS ? Row(
                              children: [
                                vm.bookingState != Constant.BOOKING_PICKUP ? Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.green,
                                      side: const BorderSide(color: Color(0xFF7EA567)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6.0)),
                                    ),
                                    onPressed: () {
                                      openAlert(context);
                                    },
                                    child: const Text(
                                      "Hủy cuốc",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Color(0xFF7EA567),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ): const SizedBox.shrink(),

                                vm.bookingState != Constant.BOOKING_PICKUP ?const SizedBox(
                                  width: 40.0,
                                ): const SizedBox.shrink(),

                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(vm.bookingState == Constant.BOOKING_VISIBLE){
                                        vm.acceptBooking(context);
                                        wsvm.booking = BookingWS(vm.bookingRes!.data!.code!);
                                      }else if(vm.bookingState == Constant.BOOKING_ACCEPTED){
                                        vm.updateStateBooking(context, Constant.BOOKING_STATE_PICKUP_SUCCESS);
                                      }else if(vm.bookingState == Constant.BOOKING_PICKUP){
                                        vm.updateStateBooking(context, Constant.BOOKING_STATE_DONE);
                                        wsvm.booking = BookingWS("0");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColor.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6.0)),
                                    ),
                                    child: Text(
                                      vm.bookingState == Constant.BOOKING_VISIBLE ?"Nhận cuốc": vm.bookingState == Constant.BOOKING_ACCEPTED ? "Đã đón khách":vm.bookingState == Constant.BOOKING_PICKUP ?"Đã đưa khách đến nơi": "",
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),

                                  ),
                                ),

                              ],
                            ) : const SizedBox.shrink(),

                            vm.bookingState == Constant.BOOKING_CUSTOMER_CANCEL || vm.bookingState == Constant.BOOKING_CANCELED || vm.bookingState == Constant.BOOKING_SUCCESS ?
                            Center(
                              child: ElevatedButton(
                              onPressed: () {
                                vm.bookingState = Constant.BOOKING_NONE;
                                vm.setNullDestinationLocation();
                                vm.notifyListeners();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColor.mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0)),
                              ),
                              child: Text(
                                vm.bookingState == Constant.BOOKING_CUSTOMER_CANCEL ?"Khách hàng đã hủy chuyến!": vm.bookingState == Constant.BOOKING_CANCELED ?"Hủy chuyến thành công":"Đã hoàn thành chuyến đi",
                                    style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),

                            ),): const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      // ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  openAlert(BuildContext context) {
    final dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      surfaceTintColor: Colors.white,
      //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Bạn muốn hủy chuyến?',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 6),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.green,
                            side: const BorderSide(color: Color(0xFF7EA567)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Quay lại",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),


                        ),
                      )
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6, right: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if(vm.bookingState == Constant.BOOKING_VISIBLE){
                            vm.rejectBooking(context);
                          } else if(vm.bookingState == Constant.BOOKING_ACCEPTED) {
                            vm.cancelBooking(context);
                          }
                          wsvm.booking = BookingWS("0");
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Text(
                          "Xác nhận",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),

                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}