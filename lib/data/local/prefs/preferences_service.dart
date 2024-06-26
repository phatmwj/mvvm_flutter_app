
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService{
  static String KEY_BEARER_TOKEN = "KEY_BEARER_TOKEN";

  static String KEY_USER_ID = "KEY_USER_ID";

  static String KEY_DRIVER_ID = "KEY_DRIVER_ID";

  Future<String?> getToken();

  void setToken(String token);

  void removeKey(String key);

  Future<int?> getDriverId();

  void setDriverId(int driverId);


}