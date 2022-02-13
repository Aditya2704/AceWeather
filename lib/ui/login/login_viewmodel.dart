import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ace_weather/app/locator.dart';
import 'package:ace_weather/app/router.gr.dart';
import 'package:ace_weather/services/shared_preference_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  bool _isLoginBtnLoading = false;
  final _apiController = TextEditingController();
  final AppRouter _appRouter = locator<AppRouter>();
  final SharedPreferenceService _prefs = locator<SharedPreferenceService>();

  TextEditingController get apiController => _apiController;

  bool get isLoginBtnLoading => _isLoginBtnLoading;

  Widget getLoginButtonContent() {
    if (_isLoginBtnLoading) {
      return const SpinKitRipple(color: Colors.white, size: 24.0);
    }
    return const Text(
      'SUBMIT',
      style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat'),
    );
  }

  void saveApiKey() async {
    _isLoginBtnLoading = true;
    notifyListeners();
    _prefs.saveToDisk("token", _apiController.text.trim());
    _appRouter.popUntilRoot();
    await _appRouter.push(const HomeViewRoute());
  }
}
