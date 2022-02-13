import 'package:ace_weather/app/router.gr.dart';
import 'package:ace_weather/services/api_service.dart';
import 'package:ace_weather/services/shared_preference_service.dart';
import 'package:ace_weather/services/snackbar_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  var instance = await SharedPreferenceService.getInstance();
  locator.registerSingleton<SharedPreferenceService>(instance);
  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerSingleton<SnackbarService>(SnackbarService());
  locator.registerSingleton<ApiService>(ApiService());
}
