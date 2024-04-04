import 'package:get_it/get_it.dart';
import 'package:mvvm_flutter_app/data/local/prefs/prefereces_service_impl.dart';
import 'package:mvvm_flutter_app/data/local/prefs/preferences_service.dart';

final GetIt locator = GetIt.instance();

void setupLocator(){
  locator.registerFactory<PreferencesService>(() => PreferencesServiceImpl());
}