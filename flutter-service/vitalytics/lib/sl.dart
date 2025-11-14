import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/network/dio_client.dart';

final sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  // Register DioClient
  sl.registerSingleton<DioClient>(await DioClient.create());
   sl.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}
