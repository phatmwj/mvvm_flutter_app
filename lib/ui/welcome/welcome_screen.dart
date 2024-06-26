
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/data/local/prefs/prefereces_service_impl.dart';
import 'package:mvvm_flutter_app/data/local/prefs/preferences_service.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/ui/login/login_screen.dart';
import 'package:mvvm_flutter_app/ui/welcome/welcome_viewmodel.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';

class WelcomeScreen extends StatefulWidget{
  static const String id = 'welcome_screen';
  const WelcomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomeScreenState();
  }

}

class _WelcomeScreenState extends State<WelcomeScreen>{

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  final PreferencesService _pref = PreferencesServiceImpl();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> checkLocationPermission() async {
    // Kiểm tra xem dịch vụ vị trí có được bật không
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // Người dùng đã từ chối bật dịch vụ vị trí
        return;
      }
    }
    // Kiểm tra xem ứng dụng có quyền truy cập vị trí không
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Người dùng đã từ chối quyền truy cập vị trí
        return;
      }
    }
    if(_permissionGranted == PermissionStatus.granted) {
      String? token = await _pref.getToken();
      if (token != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    }
    // Lấy dữ liệu vị trí hiện tại
    _locationData = await location.getLocation();
    print("Latitude: ${_locationData.latitude}, Longitude: ${_locationData.longitude}");
  }
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<WelcomeViewModel>(context);
    // TODO: implement build
    return Scaffold(
      body:
      SafeArea(
        child: Stack(
          children: [
            const Positioned(
              bottom: 250,
              child: Image(
                image: AssetImage('assets/images/logo_welcome.png'),
              ),
            ),


            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                      'Driver with AllWin',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 30.0,
                      ),
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF969696),
                        fontSize: 15.0,
                      ),
                    ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        checkLocationPermission();
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: const Color(0xFFFFFFFF),
                          primary: const Color(0xFF7EA567)
                      ),
                      child: const Text(
                        'Tiếp tục',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ) ,
      )
    );
  }

}