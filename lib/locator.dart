import 'package:get_it/get_it.dart';
import 'package:smarthome_cloud/services/navigator_service.dart';
import 'package:smarthome_cloud/services/rmq_service.dart';
import 'package:smarthome_cloud/services/sqflite_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => RMQService());
  locator.registerLazySingleton(() => Db());
}