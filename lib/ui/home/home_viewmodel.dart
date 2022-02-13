import 'dart:async';
import 'package:ace_weather/app/locator.dart';
import 'package:ace_weather/services/api_service.dart';
import 'package:ace_weather/services/shared_preference_service.dart';
import 'package:ace_weather/utils/weather_icon_mapper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/weather.dart';

bool _firstTimeCall = true;

class HomeViewModel extends StreamViewModel {
  bool _isLoading = true;
  late Position _position;
  Map _currentTime = {"hours": "", "minutes": ""};
  String _currentDay = '';
  String _currentDate = '';
  String _userLocation = '';
  // ignore: prefer_final_fields
  Map _currentWeather = {
    "temp": "",
    "minTemp": "",
    "maxTemp": "",
    "feelsLikeTemp": "",
    "weatherIcon": "",
    "weatherDescription": "",
    "hourlyForecast": []
  };
  List<Map> _futureForecast = [];
  final ApiService _weatherApiService = locator<ApiService>();
  final SharedPreferenceService _prefs = locator<SharedPreferenceService>();

  bool get isLoading => _isLoading;

  List get futureForecast => _futureForecast;

  String get userLocation => _userLocation;

  String get currentDay => _currentDay;

  Map get currentTime => _currentTime;

  String get currentDate => _currentDate;

  Map get currentWeather => _currentWeather;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDate = _formatDate(now);
    final String formattedDay = _formatDay(now);
    final Map formattedTime = _formatTime(now);
    _currentDate = formattedDate;
    _currentDay = formattedDay;
    _currentTime = formattedTime;
    notifyListeners();
  }

  Map _formatTime(DateTime dateTime) {
    String formattedTime = DateFormat('hh:mm').format(dateTime);
    return {
      "hours": formattedTime.split(":")[0],
      "minutes": formattedTime.split(":")[1]
    };
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('MMMMd').format(dateTime);
  }

  String _formatDay(DateTime dateTime) {
    return DateFormat('EEEEE').format(dateTime);
  }

  IconData getIconData(iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }

  String formatTemperature(temp) {
    temp = temp.toString().replaceAll(" Celsius", "");
    var formattedTemp = double.parse(temp).round();
    return "$formattedTemp°";
  }

  void getWeatherData() async {
    String token = await _prefs.getFromDisk('token');
    WeatherFactory wf = WeatherFactory(token);
    Weather w = await wf.currentWeatherByLocation(
        _position.latitude, _position.longitude);
    _currentWeather["temp"] = formatTemperature(w.temperature);
    _currentWeather["minTemp"] = formatTemperature(w.tempMin);
    _currentWeather["maxTemp"] = formatTemperature(w.tempMax);
    _currentWeather["feelsLikeTemp"] = formatTemperature(w.tempFeelsLike);
    _currentWeather["weatherIcon"] = w.weatherIcon;
    _currentWeather["weatherDescription"] = w.weatherMain;
    _currentWeather["hourlyForecast"] = [];
    _userLocation = "${w.areaName}, ${w.country}";
    List<Weather> forecast = await wf.fiveDayForecastByLocation(
        _position.latitude, _position.longitude);
    for (var i = 0; i < 3; i++) {
      var element = forecast[i];
      _currentWeather["hourlyForecast"].add({
        "temp": formatTemperature(element.temperature),
        "weatherDescription": element.weatherMain,
        "date":
            DateFormat('hh:mm').format(DateTime.parse(element.date.toString()))
      });
    }
    _futureForecast = [];
    final response = await _weatherApiService.futureForecast(
        _position.latitude, _position.longitude);
    for (var i = 0; i < 3; i++) {
      var element = response["daily"][i];
      String day = i == 0
          ? 'Tomorrow'
          : _formatDay(
              DateTime.fromMillisecondsSinceEpoch(element["dt"] * 1000));
      _futureForecast.add({
        "temp": formatTemperature(element["temp"]["day"]),
        "weatherIcon": element["weather"][0]["icon"],
        "weatherDescription": element["weather"][0]["main"],
        "date": day
      });
    }
    _isLoading = false;
    notifyListeners();
  }

  @override
  Stream<int> get stream => EpochService().epochUpdatesNumbers();

  @override
  void onData(data) async {
    if (_firstTimeCall) {
      _firstTimeCall = false;
      _currentTime = _formatTime(DateTime.now());
      _currentDate = _formatDate(DateTime.now());
      _currentDay = _formatDay(DateTime.now());
      notifyListeners();
      Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
    getWeatherData();
    super.onData(data);
  }
}

class EpochService {
  Stream<int> epochUpdatesNumbers() async* {
    while (true) {
      if (!_firstTimeCall) {
        await Future.delayed(const Duration(seconds: 180));
      }
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }
}
