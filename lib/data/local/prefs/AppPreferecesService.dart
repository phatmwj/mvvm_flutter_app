
import 'package:mvvm_flutter_app/data/local/prefs/PreferencesService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService extends PreferencesService{
  @override
  Future<String?> getToken() async {
    // TODO: implement getToken
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferencesService.KEY_BEARER_TOKEN);
  }

  @override
  void removeKey(String key) {
    // TODO: implement removeKey
  }

  @override
  void setToken(String token) {
    // TODO: implement setToken
    addKey(PreferencesService.KEY_BEARER_TOKEN, token);
  }

  Future<void> addKey(String key,dynamic value) async{
    final prefs = await SharedPreferences.getInstance();
    if(value is String){
      prefs.setString(key, value);
    }else if(value is int){
      prefs.setInt(key, value);
    }else if(value is double){
      prefs.setDouble(key, value);
    }else if(value is bool){
      prefs.setBool(key, value);
    }
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  
}