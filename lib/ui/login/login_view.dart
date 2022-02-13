import 'package:flutter/material.dart';
import 'package:ace_weather/ui/login/login_viewmodel.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:ace_weather/config/config.dart' as config;

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: config.backgroundColor,
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Stack(
                      children: [
                        Align(
                          child:
                              Lottie.asset('assets/data/login-animation.json'),
                        ),
                        Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          color: config.backgroundColor.withOpacity(0.75),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.07),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Ace Weather',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40.0,
                                        color: config.accentTextColor),
                                  ),
                                ),
                                const SizedBox(height: 70.0),
                                const Text(
                                  'Please enter your api key',
                                  style: TextStyle(
                                      color: config.accentTextColor,
                                      fontSize: 16.0),
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  cursorColor: config.backgroundColor,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black87),
                                  controller: model.apiController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: config.accentTextColor
                                          .withOpacity(0.7),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0))),
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: TextButton(
                                      child: model.getLoginButtonContent(),
                                      style: config.primaryButton,
                                      onPressed: () => model.isLoginBtnLoading
                                          ? null
                                          : model.saveApiKey(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
