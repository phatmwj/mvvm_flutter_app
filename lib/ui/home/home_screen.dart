
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm_flutter_app/ui/navpages/account_page.dart';

class HomeScreen extends StatefulWidget{
  static const String id = "home_screen";
  const HomeScreen({super.key});

  @override
    // TODO: implement createState
    _HomeScreenState createState()=> _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  int _selectedIndex = 0;
  //ggmaps
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Widget _homePage(){
    return Stack(
        children:[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 40.0,
            left: 16.0,
            right: 16.0,
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/user_avatar.png'),
                      width: 50.0,
                      height: 50.0,
                    ),
                    SizedBox(width: 80),
                    Text(
                      "Online"
                    ),
                    SizedBox(width: 80),
                    Switch(
                      value: true,
                      onChanged: (bool value) {
                      }, // Replace with your switch value
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
    );


  }
  late List<Widget> _pages = <Widget>[
    _homePage(),
    Text('Thu nhập'),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return
        Scaffold(
          // appBar: AppBar(
          //   title: Text('Bottom Navigation Example'),
          // ),
          body: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Thu nhập',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Tài khoản',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          ),
        );
  }
  
}