
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/ui/navpages/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../constant/Constant.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  final vm = HomePageViewModel();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Future<void> getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location){
      vm.setCurrentLocation(location);
      vm.updatePosition(context);
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
    });

    setState(() {

    });
  }

  @override
  void initState(){
    getCurrentLocation();
    vm.getProfile(context);
    vm.getServiceOnline(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      ChangeNotifierProvider<HomePageViewModel>(
        create: (BuildContext context)=> vm,
        child: Consumer<HomePageViewModel>(
          builder: (context,value,_){
            return vm.currentLocation == null ?
            const Center(
              child: CircularProgressIndicator(),
            ):Stack(
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
                    )
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
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
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}