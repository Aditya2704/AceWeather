import 'dart:convert';
import 'dart:io';

import 'package:ace_weather/app/locator.dart';
import 'package:ace_weather/services/shared_preference_service.dart';
import 'package:ace_weather/services/snackbar_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final SharedPreferenceService _prefs = locator<SharedPreferenceService>();
  final SnackbarService _snackbar = locator<SnackbarService>();

  Future<dynamic> futureForecast(double lat, double lon) async {
    String token = _prefs.getFromDisk('token');
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=current,minutely,hourly&appid=$token');
    try {
      final response = await http.get(url);
      return _returnResponse(response);
    } on SocketException {
      _snackbar.showBottomFlash("Can't connect to network", false);
    }
    return {};
  }

  dynamic _returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        _snackbar.showBottomFlash("Bad request", false);
        break;
      case 401:
      case 403:
        _snackbar.showBottomFlash("Unauthorised request", false);
        break;
      case 500:
      default:
        _snackbar.showBottomFlash("Server error", false);
    }
  }
}
