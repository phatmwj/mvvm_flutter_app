import 'package:get_it/get_it.dart';
import 'package:mvvm_flutter_app/data/local/prefs/prefereces_service_impl.dart';
import 'package:mvvm_flutter_app/data/local/prefs/preferences_service.dart';
import 'package:mvvm_flutter_app/data/remote/network/base_api_service.dart';
import 'package:mvvm_flutter_app/data/remote/network/network_api_service.dart';
import 'package:mvvm_flutter_app/repo/repository.dart';
import 'package:mvvm_flutter_app/repo/repository_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator(){

  locator.registerFactory<PreferencesService>(() => PreferencesServiceImpl());

  locator.registerFactory<BaseApiService>(() => NetworkApiService());

  locator.registerFactory<Repository>(() => RepositoryImpl());

}