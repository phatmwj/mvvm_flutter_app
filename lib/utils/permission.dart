
import 'package:location/location.dart';

class Permission{
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

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
    if(_permissionGranted == PermissionStatus.granted){
    }
    // Lấy dữ liệu vị trí hiện tại
    _locationData = await location.getLocation();
    print("Latitude: ${_locationData.latitude}, Longitude: ${_locationData.longitude}");
  }
}