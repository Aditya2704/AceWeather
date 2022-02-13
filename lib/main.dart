import 'package:flutter/material.dart';
import 'package:ace_weather/app/locator.dart';
import 'package:ace_weather/app/router.gr.dart';
import 'package:ace_weather/services/shared_preference_service.dart';
import 'package:ace_weather/config/config.dart' as config;
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationPermission permission = await Geolocator.checkPermission();
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled) {
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // if (permission == LocationPermission.denied) {
      //   print('Location permissions are denied');
      // }
    }
  }
  await setupLocator();
  final _prefs = locator<SharedPreferenceService>();
  final _appRouter = locator<AppRouter>();
  // _prefs.removeFromDisk("token");
  String? token = _prefs.getFromDisk("token");
  runApp(MaterialApp.router(
    routeInformationParser: _appRouter.defaultRouteParser(),
    routerDelegate: _appRouter.delegate(initialRoutes: [
      if (token != null) const HomeViewRoute() else const LoginViewRoute()
    ]),
    debugShowCheckedModeBanner: false,
    scaffoldMessengerKey: config.snackbarKey,
    theme: ThemeData(fontFamily: 'Jost'),
  ));
}
